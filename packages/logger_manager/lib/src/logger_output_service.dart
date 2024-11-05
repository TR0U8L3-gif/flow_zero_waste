import 'package:logger/logger.dart';
import 'package:logger_manager/core/enums/enums.dart';

/// Abstract class for logger output service
abstract class LoggerOutputService {
  /// Constructor for LoggerOutputService
  const LoggerOutputService({
    required this.canLog,
    required this.buildType,
    required this.logLevel,
  });

  /// Log function
  void log(OutputEvent event);

  /// check if service is enabled
  final bool canLog;

  /// build type
  final LoggerBuildTypes buildType;

  /// minimal log level
  final Level logLevel;

  @override
  String toString() {
    return [
      '$runtimeType',
      '{canLog: $canLog, buildType: $buildType, logLevel: $logLevel}',
    ].join('\n');
  }
}
