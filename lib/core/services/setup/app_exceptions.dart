import 'package:flow_zero_waste/core/common/data/exceptions.dart';

/// Exception thrown when app setup fails
class AppSetupException extends BaseException {
  /// AppSetup exception constructor
  const AppSetupException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// Exception thrown when app environment fails
class AppEnvException extends BaseException {
  /// AppEnv exception constructor
  const AppEnvException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}
