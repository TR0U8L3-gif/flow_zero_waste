import 'dart:convert';
import 'dart:typed_data';

import 'package:flow_zero_waste/core/common/data/exceptions.dart';
import 'package:hive/hive.dart';

/// Default value for the compact threshold.
/// 
/// The compact threshold is the number of changed entries
const compactThresholdDefault = 50;

/// HiveManager is a class that manages the Hive box for a specific type.
abstract class HiveManager<T> {
  /// Constructor for HiveManager
  HiveManager({required String boxName, int? compactThreshold})
      : _boxName = boxName,
        _compactThreshold = compactThreshold ?? compactThresholdDefault;

  final String _boxName;
  final int _compactThreshold;
  bool _isBoxOpen = false;

  /// Returns the name of the box.
  String get boxName => _boxName;

  /// Returns true if the box is open, false otherwise.
  bool get isBoxOpen => _isBoxOpen;

  /// Returns the key for the box.
  String _boxKey(String key) => '${boxName}_$key';

  /// Returns the Hive box.
  Future<Box<T>> get _hiveBox async {
    if (_isBoxOpen) {
      return _getBox();
    } else {
      try {
        final box = await _openBox();
        _isBoxOpen = true;
        return box;
      } catch (e, st) {
        _isBoxOpen = false;
        throw HiveManagerException(
          sender: e.toString(),
          description: 'open box',
          stackTrace: st,
        );
      }
    }
  }

  /// Opens the box.
  Future<Box<T>> _openBox() => Hive.openBox<T>(
        boxName,
        compactionStrategy: (entries, deletedEntries) =>
            deletedEntries >= _compactThreshold,
      );

  /// Returns the box.
  Box<T> _getBox() => Hive.box<T>(boxName);

  /// Closes the box.
  Future<void> closeBox() async {
    if (_isBoxOpen) {
      _isBoxOpen = false;
      final box = _getBox();
      await box.compact();
      await box.close();
    }
  }

  /// Reads the value from the box.
  Future<T?> read({required String key}) async {
    final box = await _hiveBox;
    return box.get(_boxKey(key));
  }

  /// Writes the value to the box.
  Future<void> write(T input, {required String key}) async {
    final box = await _hiveBox;
    return box.put(_boxKey(key), input);
  }

  /// Deletes the value from the box.
  Future<void> delete({required String key}) async {
    final box = await _hiveBox;
    return box.delete(_boxKey(key));
  }

  /// Deletes all values from the box.
  Future<void> deleteAll() async {
    final box = await _hiveBox;
    final values = box.keys;
    return box.deleteAll(values);
  }
}

/// HiveSecureManager is a class that manages the Hive box
/// for a specific type with encryption.
abstract class HiveSecureManager<T> extends HiveManager<T> {
  /// Constructor for HiveSecureManager
  HiveSecureManager({
    required super.boxName,
    required String encryptionKey,
  }) : _encryptionKeyUint8List = base64Url.decode(encryptionKey);

  final Uint8List _encryptionKeyUint8List;

  @override
  Future<Box<T>> _openBox() => Hive.openBox<T>(
        boxName,
        encryptionCipher: HiveAesCipher(_encryptionKeyUint8List),
        compactionStrategy: (entries, deletedEntries) =>
            deletedEntries >= _compactThreshold,
      );
}
