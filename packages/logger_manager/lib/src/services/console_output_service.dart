import 'dart:developer' as dev;
import 'package:logger/logger.dart';
import 'package:logger_manager/logger_manager.dart';

/// ConsoleOutputService class
class ConsoleOutputService extends LoggerOutputService {
  /// Constructor for ConsoleOutputService
  const ConsoleOutputService({
    required super.canLog,
    required super.buildType,
    required super.logLevel,
  });

  @override
  void log(OutputEvent event) {
    // check if can log
    if (!canLog) return;

    // check if log level high enough
    if (event.level.index < logLevel.index) return;

    // print log
    dev.log(event.lines.join('\n'));
  }
}
