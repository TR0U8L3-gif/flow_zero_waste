import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:logger/web.dart';
import 'package:logger_manager/logger_manager.dart';

/// LoggerManager class
abstract class LoggerManager {
  /// LoggerManager constructor
  LoggerManager();

  Logger? _logger;
  LoggerPrinter? _printer;
  LoggerOutput? _output;
  LoggerFilter? _filter;

  /// logger getter
  Logger get logger {
    return _logger ??= build(LoggerBuildTypes.production);
  }

  /// filter getter
  LoggerFilter? get filter {
    return _filter;
  }

  /// printer getter
  LoggerPrinter? get printer {
    return _printer;
  }

  /// output getter
  LoggerOutput? get output {
    return _output;
  }

  /// build Logger method
  Logger build(LoggerBuildTypes type) {
    filter = LoggerFilter();
    printer = LoggerPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    );
    output = LoggerOutput(
      logServices: [
        ConsoleOutputService(
          canLog: true,
          logLevel: Level.all,
          buildType: type,
        ),
        TerminalOutputService(
          canLog: true,
          logLevel: Level.all,
          buildType: type,
        ),
      ],
    );

    return Logger(
      filter: filter,
      printer: printer,
      output: output,
      level: Level.all,
    );
  }

  /// setPrinter method
  @protected
  set filter(LoggerFilter? filter) => _filter = filter;

  /// setPrinter method
  @protected
  set printer(LoggerPrinter? printer) => _printer = printer;

  /// setOutput method
  @protected
  set output(LoggerOutput? output) => _output = output;

  /// getService from output logServices
  Type? getService<Type>() {
    return _output?.logServices.firstWhereOrNull(
      (element) => element is Type,
    ) as Type?;
  }

  /// create logger from build type
  void createLogger({required String type}) {
    try {
      final buildType = LoggerBuildTypes.values.byName(type);
      _logger = build(buildType);
    } catch (e) {
      _logger = build(LoggerBuildTypes.production);
      throw Exception('LoggerBuildTypes not found for $type');
    }
  }

  /// Log a message at level [Level.trace].
  void trace({
    required String message,
    DateTime? time,
    String? problemId,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalProperties,
  }) {
    logger.log(
      Level.trace,
      LoggerMessage(
        message: message,
        problemId: problemId,
        additionalProperties: additionalProperties,
      ),
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.debug].
  void debug({
    required String message,
    DateTime? time,
    String? problemId,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalProperties,
  }) {
    logger.log(
      Level.debug,
      LoggerMessage(
        message: message,
        problemId: problemId,
        additionalProperties: additionalProperties,
      ),
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.info].
  void info({
    required String message,
    DateTime? time,
    String? problemId,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalProperties,
  }) {
    logger.log(
      Level.info,
      LoggerMessage(
        message: message,
        problemId: problemId,
        additionalProperties: additionalProperties,
      ),
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.warning].
  void warning({
    required String message,
    DateTime? time,
    String? problemId,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalProperties,
  }) {
    logger.log(
      Level.warning,
      LoggerMessage(
        message: message,
        problemId: problemId,
        additionalProperties: additionalProperties,
      ),
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.error].
  void error({
    required String message,
    DateTime? time,
    String? problemId,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalProperties,
  }) {
    logger.log(
      Level.error,
      LoggerMessage(
        message: message,
        problemId: problemId,
        additionalProperties: additionalProperties,
      ),
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.fatal].
  void fatal({
    required String message,
    DateTime? time,
    String? problemId,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalProperties,
  }) {
    logger.log(
      Level.fatal,
      LoggerMessage(
        message: message,
        problemId: problemId,
        additionalProperties: additionalProperties,
      ),
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

/// Class that print logs
class LoggerPrinter extends PrettyPrinter {
  /// Constructor for LoggerPrinter
  LoggerPrinter({
    required super.methodCount,
    required super.errorMethodCount,
    required super.lineLength,
    required super.printEmojis,
    required super.dateTimeFormat,
  });

  @override
  String toString() {
    return [
      'methodCount: $methodCount',
      'errorMethodCount: $errorMethodCount',
      'lineLength: $lineLength',
      'printEmojis: $printEmojis',
      'dateTimeFormat: $dateTimeFormat',
    ].join(', ');
  }
}

/// Class that output logs
class LoggerOutput extends LogOutput {
  /// Constructor for LoggerOutput
  LoggerOutput({
    required this.logServices,
  });

  /// List of log services
  final List<LoggerOutputService> logServices;

  @override
  void output(OutputEvent event) {
    for (final service in logServices) {
      service.log(event);
    }
  }

  @override
  String toString() {
    return logServices.map((e) => e.toString()).join('\n');
  }
}

/// Class that filter logs
class LoggerFilter extends LogFilter {
  /// Constructor for LoggerFilter
  LoggerFilter();

  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
