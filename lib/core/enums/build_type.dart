/// BuildType enum
enum BuildTypes {
  /// Development
  debug,

  /// Demonstration
  profile,

  /// Production
  release;

  /// Decide the value based on the build type.
  Type decideBuildType<Type>({
    required Type debug,
    required Type profile,
    required Type release,
  }) {
    switch (this) {
      case BuildTypes.debug:
        return debug;
      case BuildTypes.profile:
        return profile;
      case BuildTypes.release:
        return release;
    }
  }
}
