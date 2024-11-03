/// Page layout size enum
enum PageLayoutSize{
  /// Extra large
  extraLarge,
  /// Large
  large,
  /// Expanded
  expanded,
  /// Medium
  medium,
  /// Compact
  compact;

  /// Get the name of the enum
  @override
  String toString() => name;

  /// check if the enum is extra large
  bool get isExtraLarge => this == PageLayoutSize.extraLarge;
  /// check if the enum is large
  bool get isLarge => this == PageLayoutSize.large;
  /// check if the enum is expanded
  bool get isExpanded => this == PageLayoutSize.expanded;
  /// check if the enum is medium
  bool get isMedium => this == PageLayoutSize.medium;
  /// check if the enum is compact
  bool get isCompact => this == PageLayoutSize.compact;
}
