/// App exception
abstract class BaseException implements Exception {
  /// App exception constructor
  const BaseException({
    required this.sender,
    required this.description,
    this.stackTrace,
  });

  /// Exception description
  /// Write what happened in short phrases
  /// Example: 'instance check => get data => decode as map => fromJson' 
  final String description;

  /// Exception sender
  /// Pass Exception toString value or describe the sender
  /// Example: '(Class.method): overall description'
  final String sender;

  /// Exception stack trace
  final StackTrace? stackTrace;

  /// Exception message
  String get message => '($description) $sender';
}

/// Exception thrown when app setup fails
class AppSetupException extends BaseException {
  /// AppSetup exception constructor
  const AppSetupException({
    required super.sender,
    required super.description,
    super.stackTrace,
  });
}

/// Exception thrown when navigation fails
class NavigateException extends BaseException {
  /// Navigate exception constructor
  const NavigateException({
    required super.sender,
    required super.description,
    required this.navigationType,
    required this.routeRuntimeType,
    super.stackTrace,
  });

  /// Navigation type
  final String navigationType;

  /// Route runtime type
  final String routeRuntimeType;

  @override
  String get message =>
      '$sender: ($navigationType, $routeRuntimeType) $description ';
}

/// Exception thrown when app environment fails
class AppEnvException extends BaseException {
  /// AppEnv exception constructor
  const AppEnvException({
    required super.sender,
    required super.description,
    super.stackTrace,
  });
}

/// Exception thrown when hive manager fails
class HiveManagerException extends BaseException {
  /// HiveManager exception constructor
  const HiveManagerException({
    required super.sender,
    required super.description,
    super.stackTrace,
  });
}

/// Exception thrown when local storage fails
class LocalStorageException extends BaseException {
  /// LocalStorage exception constructor
  const LocalStorageException({
    required super.sender,
    required super.description,
    super.stackTrace,
  });
}
