/// Logger build types
enum LoggerBuildTypes {
  /// Development
  debug,

  /// Demonstration
  profile,

  /// Production
  production,
}

/// Decide the value based on the build type.
Type decideLoggerBuildType<Type>(
  LoggerBuildTypes type, {
  required Type debug,
  required Type profile,
  required Type production,
}) {
  switch (type) {
    case LoggerBuildTypes.debug:
      return debug;
    case LoggerBuildTypes.profile:
      return profile;
    case LoggerBuildTypes.production:
      return production;
  }
}
