/// App exception
abstract class BaseException implements Exception {
  /// App exception constructor
  const BaseException({required this.sender, required this.description});

  /// Exception description
  final String description;

  /// Exception sender
  final String sender;

  /// Exception message
  String get message => '$sender: $description';
}

/// Exception thrown when app setup fails
class AppSetupException extends BaseException {
  /// AppSetup exception constructor
  const AppSetupException({
    required super.sender,
    required super.description,
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
  });
}

/// Exception thrown when hive manager fails
class HiveManagerException extends BaseException {
  /// HiveManager exception constructor
  const HiveManagerException({
    required super.sender,
    required super.description,
  });
}
