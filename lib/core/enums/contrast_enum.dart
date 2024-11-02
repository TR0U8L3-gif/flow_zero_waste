/// Enum for contrast
enum Contrast {
  /// High contrast
  high,

  /// Medium contrast
  medium,

  /// Standard contrast
  standard;

  /// check if the enum is high contrast
  bool get isHigh {
    return this == Contrast.high;
  }

  /// check if the enum is medium contrast
  bool get isMedium {
    return this == Contrast.medium;
  }

  /// check if the enum is standard contrast
  bool get isStandard {
    return this == Contrast.standard;
  }
}
