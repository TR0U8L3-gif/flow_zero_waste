import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:logger_manager/core/helpers/fixed_sized_heap.dart';
import 'package:logger_manager/core/helpers/get_file_from_assets.dart';
import 'package:logger_manager/logger_manager.dart';

/// FileOutputService class
///
/// This class is used to log output to a file
///
class FileOutputService extends LoggerOutputService {
  /// Constructor for FileOutputService
  FileOutputService({
    required super.canLog,
    required super.buildType,
    required super.logLevel,
    this.capacity = 12,
    this.fileName = 'workai',
    this.flushDelay = const Duration(seconds: 90),
    this.fileMaxSize = 819200, // 800 KB
    this.fileStackTraceMaxLines = 5,
  }) {
    if (canLog) {
      _initialize();
    }
  }

  File? _filePrimary;
  File? _fileSecondary;
  File? _fileTertiary;

  /// Capacity of the heap
  final int capacity;

  /// File name
  final String fileName;

  /// File extension
  final String fileExtension = '.workai';

  /// max number of lines in a file
  final int fileStackTraceMaxLines;

  /// max number of lines in a file
  final int fileMaxSize;

  /// max length of a line
  final int lineMaxLength = 160;

  /// Heap of hashed logs
  late final FixedSizeHeap<List<String>> _heap;

  /// Data flush delay
  final Duration flushDelay;

  /// current file index
  FileIndex _currentFileIndex = FileIndex.primary;

  /// is initialized
  bool _isInitialized = false;

  /// RSA publicKey
  RSAPublicKey? _rsaPublicKey;

  /// Timer for flushing data
  Timer? _timer;

  /// Save to file stream controller
  final _saveStreamController =
      StreamController<List<List<String>>>.broadcast();

  /// hash data stream controller
  final _hashStreamController = StreamController<List<String>>.broadcast();

  /// Get rsa public key
  RSAPublicKey? get rsaPublicKey => _rsaPublicKey;

  /// Get is initialized
  bool get isInitialized => _isInitialized;

  /// Get timer
  Timer? get timer => _timer;

  /// Get current file index
  FileIndex get currentFileIndex => _currentFileIndex;

  /// Get heap
  FixedSizeHeap<List<String>> get outputEventsHeap => _heap;

  /// Initialize
  Future<void> _initialize() async {
    if (_isInitialized) return;

    // create heap
    _heap = FixedSizeHeap<List<String>>(maxSize: capacity);

    await Future.wait([
      _getFile(FileIndex.primary),
      _getFile(FileIndex.secondary),
      _getFile(FileIndex.tertiary),
      _getPublicKey(),
    ]).then((List<dynamic> data) {
      final primaryData = data[0] as ({File file, int size});
      final secondaryData = data[1] as ({File file, int size});
      final tertiaryData = data[2] as ({File file, int size});
      final rsaPublicKey = data[3] as RSAPublicKey;

      // set rsa public key
      _rsaPublicKey = rsaPublicKey;

      // set files
      _filePrimary = primaryData.file;
      _fileSecondary = secondaryData.file;
      _fileTertiary = tertiaryData.file;

      // check last opened file
      if (primaryData.size >= fileMaxSize) {
        if (secondaryData.size >= fileMaxSize) {
          _currentFileIndex = FileIndex.tertiary;
        } else {
          _currentFileIndex = FileIndex.secondary;
        }
      } else {
        if (tertiaryData.size == 0 || tertiaryData.size >= fileMaxSize) {
          _currentFileIndex = FileIndex.primary;
        } else {
          _currentFileIndex = FileIndex.tertiary;
        }
      }

      // set up the timer
      _timer = _setupTimer(flushDelay);

      // listen to hash stream
      _hashStreamController.stream.listen((data) async {
        // wait for data to be hashed
        final hashed = await _hashLog(data);
        // push hashed data to heap
        _heap.push(hashed);
      });

      // listen to save stream
      _saveStreamController.stream.listen((data) async => _saveToFile(data));

      _isInitialized = true;
    }).onError((e, st) {
      dev.log(
        'Error initializing logging files or current file index',
        error: e,
        stackTrace: st,
      );
      _isInitialized = false;
      return;
    });
  }

  /// Get file from assets
  Future<({File file, int size})> _getFile(FileIndex index) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${_fileName(index)}');
    if (!file.existsSync()) {
      file.createSync();
    }
    final size = file.lengthSync();
    return (file: file, size: size);
  }

  /// Get file name
  String _fileName(FileIndex index) {
    return '${fileName}_${index.name}_log$fileExtension';
  }

  /// Get file by index
  File? _getFileByIndex(FileIndex index) {
    if (index == FileIndex.primary) {
      return _filePrimary;
    } else if (index == FileIndex.secondary) {
      return _fileSecondary;
    } else {
      return _fileTertiary;
    }
  }

  /// increment file index
  FileIndex _incrementFileIndex(FileIndex index, [int increment = 1]) {
    return FileIndex
        .values[(index.index + increment) % FileIndex.values.length];
  }

  /// get public key
  Future<RSAPublicKey> _getPublicKey() async {
    if (_rsaPublicKey != null) return _rsaPublicKey!;
    final file = await getFileFromAssets('keys/rsa_public_key.pem');
    final key = await file.readAsString();
    return RSAKeyParser().parse(key) as RSAPublicKey;
  }

  /// hash log
  Future<List<String>> _hashLog(List<String> lines) async {
    //check if lines are no longer than `lineMaxLength` characters
    final croppedLines = <String>[];

    for (final line in lines) {
      if (line.length > lineMaxLength) {
        croppedLines.add(line.substring(0, lineMaxLength));
      } else {
        croppedLines.add(line);
      }
    }

    // get rsa public key
    _rsaPublicKey ??= await _getPublicKey();

    // create encrypter
    Encrypter encrypter;

    try {
      encrypter = Encrypter(RSA(publicKey: _rsaPublicKey));
    } catch (e) {
      dev.log('FileOutputService._hashLog: Error creating RSA encrypter: $e');
      rethrow;
    }
    // set up receive port
    final receivePort = ReceivePort();

    // isolate to hash data
    await Isolate.spawn(
      _hashIsolate,
      HashData(
        sendPort: receivePort.sendPort,
        encrypter: encrypter,
        lines: croppedLines,
      ),
    );

    // get hashed data
    final hashed = await receivePort.first as List<String>;

    // close receive port
    receivePort.close();

    // return hashed data
    return hashed;
  }

  /// get data from event
  List<String> _getData(OutputEvent event) {
    // get stack trace
    final st = event.origin.stackTrace ?? StackTrace.current;

    // get stack trace lines and convert them to string
    final sts = <String>[];
    for (final value in st.toString().trimRight().split('\n').take(5)) {
      sts.add(value);
    }

    // get error
    final errors = event.origin.error?.toString();

    // set message and problem id
    var msg = '';
    String? problemId;

    // get message and problem id
    if (event.origin.message is LoggerMessage) {
      final lm = event.origin.message as LoggerMessage;
      msg = lm.message;
      problemId = lm.problemId;
    } else {
      msg = event.origin.message.toString();
    }

    // create log title
    final log = [
      DateFormat('yyyy-MM-dd HH:mm:ss').format(event.origin.time),
      event.level.name,
      if (problemId != null) problemId,
    ].join(' | ');

    // create log lines
    final lines = <String>[
      if (log.isNotEmpty) log.substring(0, min(log.length, lineMaxLength)),
      if (msg.isNotEmpty) msg.substring(0, min(msg.length, lineMaxLength)),
      if (errors != null)
        errors.substring(0, min(errors.length, lineMaxLength)),
      ...sts.map((e) => e.substring(0, min(e.length, lineMaxLength))),
    ];

    // if(kDebugMode){
    //   for (var element in lines) {
    //     dev.log('${element.length} : $element\n');
    //   }
    // }

    // return lines
    return lines;
  }

  /// setup periodic timer to flush data
  Timer _setupTimer(Duration duration) {
    return Timer.periodic(flushDelay, (_) {
      if (!_isInitialized) return;
      _flush();
    });
  }

  /// flush data
  void _flush() {
    // get data
    final data = _heap.heap.reversed.toList();
    if (data.isEmpty) return;

    // add data to save stream
    _saveStreamController.sink.add(data);
    // clear heap
    _heap.clearAll();
  }

  /// save data to file
  Future<void> _saveToFile(List<List<String>> data) async {
    if (data.isEmpty) return;

    // set up receive port
    final receivePort = ReceivePort();

    // get current file
    final currentFile = _getFileByIndex(_currentFileIndex);
    if (currentFile == null) {
      throw Exception('[ERROR] FileOutputService: Current file is null');
    }

    // get file to determine if delete is needed
    final deleteFile = _getFileByIndex(_incrementFileIndex(_currentFileIndex));
    if (deleteFile == null) {
      throw Exception('[ERROR] FileOutputService: Delete file is null');
    }

    // spawn isolate to save data
    await Isolate.spawn(
      _saveIsolate,
      SaveData(
        file: currentFile,
        lines: data,
        deleteFile: deleteFile,
        maxFileSize: fileMaxSize,
        sendPort: receivePort.sendPort,
      ),
    );

    // get file size
    final fileSize = await receivePort.first as int;

    // close receive port
    receivePort.close();

    // if file size is greater than max size, change current file index
    if (fileSize >= fileMaxSize) {
      if (_currentFileIndex == FileIndex.primary) {
        _currentFileIndex = FileIndex.secondary;
      } else if (_currentFileIndex == FileIndex.secondary) {
        _currentFileIndex = FileIndex.tertiary;
      } else {
        _currentFileIndex = FileIndex.primary;
      }
    }
  }

  @override
  void log(OutputEvent event) {
    // check if can log
    if (!canLog) return;

    // check if log level high enough
    if (event.level.index < logLevel.index) return;

    // reset timer
    _timer?.cancel();
    _timer = _setupTimer(flushDelay);

    // get data
    final lines = _getData(event);

    // if heap is full, flush data
    if (_heap.isFull) {
      _flush();
    }

    // add data to hash stream
    _hashStreamController.sink.add(lines);
  }

  /// flush all data
  void flushAllData() {
    _flush();
  }

  /// clear all files
  void clearAllFiles() {
    try {
      Future.wait([
        _filePrimary!.writeAsString(''),
        _fileSecondary!.writeAsString(''),
        _fileTertiary!.writeAsString(''),
      ]);
      return;
    } catch (e) {
      throw Exception(
        '[ERROR] FileOutputService: Error clearing all files\n$e',
      );
    }
  }

  /// get two most recent log files
  Future<({File? primary, File? secondary})> getLogFiles() async {
    var file1 = _getFileByIndex(_currentFileIndex);
    var file2 = _getFileByIndex(_incrementFileIndex(_currentFileIndex, -1));

    if (file1 != null) {
      if (await file1.length() == 0) {
        file1 = null;
      }
    }

    if (file2 != null) {
      if (await file2.length() == 0) {
        file2 = null;
      }
    }

    return (primary: file1, secondary: file2);
  }
}

/// FileIndex enum
enum FileIndex {
  /// primary file
  primary,

  /// secondary file
  secondary,

  /// tertiary file
  tertiary,
}

/// HashData class
///
/// class to hold data for hashing isolate
class HashData {
  /// Constructor for HashData
  HashData(
      {required this.sendPort, required this.encrypter, required this.lines});

  /// SendPort
  final SendPort sendPort;

  /// Encrypter
  final Encrypter encrypter;

  /// Lines
  final List<String> lines;
}

/// SaveData class
///
/// class to hold data for saving isolate
class SaveData {
  /// Constructor for SaveData
  const SaveData({
    required this.sendPort,
    required this.lines,
    required this.file,
    required this.deleteFile,
    required this.maxFileSize,
  });

  /// SendPort
  final SendPort sendPort;

  /// Lines
  final List<List<String>> lines;

  /// File
  final File file;

  /// Delete File
  final File deleteFile;

  /// Max file size
  final int maxFileSize;
}

/// hash isolate function
void _hashIsolate(HashData data) {
  // hash data
  final hashed = <String>[];
  // encrypt each line
  for (final line in data.lines) {
    Encrypted? encrypted;

    try {
      encrypted = data.encrypter.encrypt(line);
    } catch (e) {
      dev.log(
          'FileOutputService._hashIsolate: Error encrypting line (${line.length}): $e');
    }

    if (encrypted != null) {
      hashed.add(encrypted.base64);
    }
  }
  data.sendPort.send(hashed);
}

/// save isolate function
void _saveIsolate(SaveData data) {
  // get lines
  final lines = '${data.lines.map((e) => e.join('\n')).join('\n')}\n';
  // write lines to file
  data.file.writeAsStringSync(lines, mode: FileMode.append);
  // get file size
  final size = data.file.lengthSync();
  // check if file size is greater than max size
  if (size >= data.maxFileSize) {
    // clear delete file
    data.deleteFile.writeAsStringSync('');
  }
  // send file size
  data.sendPort.send(size);
}
