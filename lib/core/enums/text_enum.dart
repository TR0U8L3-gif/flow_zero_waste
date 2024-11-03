/// Text scale enum
enum TextScale {
  /// Small text scale
  small,
  /// Medium text scale
  medium,
  /// Large text scale
  large;

  /// Return TextScale from double value
  static TextScale fromDouble(double scale) {
    if (scale < 1.0) {
      return TextScale.small;
    } else if (scale < 1.6) {
      return TextScale.medium;
    } else {
      return TextScale.large;
    }
  }
}

/// Text size enum
enum TextSize {
  /// Large text size
  large,
  /// Medium text size
  medium,
  /// Small text size
  small;
}

/// Heading level enum
enum HeadingLevel {
  /// Heading level 1
  h1,
  /// Heading level 2
  h2,
  /// Heading level 3
  h3,
  /// Heading level 4
  h4,
  /// Heading level 5
  h5,
  /// Heading level 6
  h6;

  /// Return value of heading level
  int get value {
    switch (this) {
      case HeadingLevel.h1:
        return 1;
      case HeadingLevel.h2:
        return 2;
      case HeadingLevel.h3:
        return 3;
      case HeadingLevel.h4:
        return 4;
      case HeadingLevel.h5:
        return 5;
      case HeadingLevel.h6:
        return 6;
    }
  }
}
