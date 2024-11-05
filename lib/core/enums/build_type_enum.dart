import 'package:flutter/foundation.dart';

/// BuildType enum
enum BuildType {
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
      case BuildType.debug:
        return debug;
      case BuildType.profile:
        return profile;
      case BuildType.release:
        return release;
    }
  }

  /// Get the build type from flutter.
  static BuildType get fromFlutter {
    if(kDebugMode){
      return BuildType.debug;
    }
    else if(kProfileMode){
      return BuildType.profile;
    }
    else {
      return BuildType.release;
    }
  }
}
