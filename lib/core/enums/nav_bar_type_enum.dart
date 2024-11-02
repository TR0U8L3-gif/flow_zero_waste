/// enum for nav bar type
enum NavBarType {
  /// Bottom nav bar without labels
  bottom,
  /// Bottom nav bar with only active label
  bottomSemiExtended,
  /// Bottom nav bar with visible all labels
  bottomExtended,
  /// Rail nav bar with shrunk items
  rail,
  /// Rail nav bar with extended items.
  railExtended;

  /// Returns true if the nav bar type is bottom nav bar.
  bool get isBottom =>
      this == NavBarType.bottom ||
      this == NavBarType.bottomExtended ||
      this == NavBarType.bottomSemiExtended;
  /// Returns true if the nav bar type is rail nav bar.
  bool get isRail => this == NavBarType.rail || this == NavBarType.railExtended;
}
