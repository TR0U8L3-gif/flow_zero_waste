/// Logger build types
enum LoggerBuildTypes {
  /// Development
  debug,

  /// Demonstration
  profile,

  /// Production
  release,
}

/// Decide the value based on the build type.
Type decideLoggerBuildType<Type>(
  LoggerBuildTypes type, {
  required Type debug,
  required Type profile,
  required Type release,
}) {
  switch (type) {
    case LoggerBuildTypes.debug:
      return debug;
    case LoggerBuildTypes.profile:
      return profile;
    case LoggerBuildTypes.release:
      return release;
  }
}
