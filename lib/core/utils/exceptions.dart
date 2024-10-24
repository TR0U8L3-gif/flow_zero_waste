/// App exception
abstract class BaseException implements Exception {
  /// App exception constructor
  BaseException({required this.sender, required this.description});

  /// Exception description
  final String description;

  /// Exception sender
  final String sender;

  /// Exception message
  String get message => '$sender: $description';
}

/// Exception thrown when navigation fails
class NavigateException extends BaseException {
  /// Navigate exception constructor
  NavigateException({
    required super.sender,
    required super.description,
    required this.navigationType,
    required this.routeRuntimeType,
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
  AppEnvException({
    required super.sender,
    required super.description,
  });
}

/// Exception thrown when hive manager fails
class HiveManagerException extends BaseException {
  /// HiveManager exception constructor
  HiveManagerException({
    required super.sender,
    required super.description,
  });
}
