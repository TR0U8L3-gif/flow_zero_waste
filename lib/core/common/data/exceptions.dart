/// App exception
abstract class BaseException implements Exception {
  /// App exception constructor
  const BaseException({
    required this.error,
    required this.action,
    this.stackTrace,
  });

  /// Exception performed action
  /// Write what happened in short phrases
  /// Example: 'instance check => get data => decode as map => fromJson'
  final String action;

  /// Exception error data
  /// Pass Exception toString value or describe the sender
  /// Example: '(Class.method): overall description'
  final Object error;

  /// Exception stack trace
  final StackTrace? stackTrace;

  /// Exception message
  String get message => '($action) => $error';
}

/// Exception thrown when navigation fails
class NavigateException extends BaseException {
  /// Navigate exception constructor
  const NavigateException({
    required super.error,
    required super.action,
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
      '($action [$navigationType, $routeRuntimeType $action]) => $error';
}

/// Exception thrown when local storage fails
class CacheException extends BaseException {
  /// LocalStorage exception constructor
  const CacheException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// Exception thrown when server fails
class ServerException extends BaseException {
  /// Server exception constructor
  const ServerException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}
