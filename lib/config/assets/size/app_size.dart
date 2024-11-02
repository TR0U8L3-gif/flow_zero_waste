/// Class to define the size of the app
class AppSize {
  AppSize._();

  /// Size

  /// Zero size 0
  static const double zero = 0;

  /// Zero size 1
  static const double one = 1;

  /// Small size 2
  static const double s2 = 2;

  /// Small size 4
  static const double s4 = 4;

  /// Small size 6
  static const double s6 = 6;

  /// Small size 8
  static const double s = 8;

  /// Small to medium size 10
  static const double sm = 10;

  /// Medium size 12
  static const double m12 = 12;

  /// Medium size 14
  static const double m14 = 14;

  /// Medium size 16
  static const double m = 16;

  /// Medium size 18
  static const double m18 = 18;

  /// Medium to large size 20
  static const double ml = 20;

  /// Large size 22
  static const double l22 = 22;

  /// Large size 24
  static const double l = 24;

  /// Large size 26
  static const double l26 = 26;

  /// Large size 28
  static const double l28 = 28;

  /// Large to extra large size 30
  static const double lxl = 30;

  /// Extra large size 32
  static const double xl = 32;

  /// Extra large size 36
  static const double xl36 = 36;

  /// Extra large size 40
  static const double xl40 = 40;

  /// Double extra large size 48
  static const double xxl = 48;

  /// Double extra large size 56
  static const double xxl56 = 56;

  /// Triple extra large size 64
  static const double xxxl = 64;

  /// Triple extra large size 72
  static const double xxxl72 = 72;

  /// Triple extra large size 80
  static const double xxxl80 = 80;

  /// Triple extra large size 88
  static const double xxxl88 = 88;

  /// Triple extra large size 96
  static const double xxxl96 = 96;

  /// Duration

  /// Extra Small duration 200 milliseconds
  static const int durationExtraSmall = 200;

  /// Small duration 400 milliseconds
  static const int durationSmall = 400;

  /// Medium duration 800 milliseconds
  static const int durationMedium = 800;

  /// Large duration 2 seconds
  static const int durationLarge = 2000;

  /// Extra Large duration 5 seconds
  static const int durationExtraLarge = 5000;

  /// Layout type

  /// Compact layout: Width < 600
  ///
  /// Example: Phone in portrait mode
  static const ({double min, double max}) layoutCompact = (min: 0, max: 599);

  /// Medium layout:  600 <= Width < 840
  ///
  /// Example: Tablet in portrait mode, Foldable phone in portrait mode
  static const ({double min, double max}) layoutMedium = (min: 600, max: 839);

  /// Expanded layout:  840 <= Width < 1200
  ///
  /// Example: Phone, Tablet, Foldable in landscape mode, Desktop
  static const ({double min, double max}) layoutExpanded =
      (min: 840, max: 1199);

  /// Large layout:  1200 <= Width < 1600
  ///
  /// Example: Desktop
  static const ({double min, double max}) layoutLarge = (min: 1200, max: 1599);

  /// Extra Large layout:  1600 <= Width
  ///
  /// Example: Desktop, Ultra-wide
  static const ({double min, double max}) layoutExtraLarge =
      (min: 1600, max: double.infinity);

  /// List of layout types
  ///
  /// Order of the list is from largest to smallest
  static const List<({double min, double max})> layoutList = [
    layoutExtraLarge,
    layoutLarge,
    layoutExpanded,
    layoutMedium,
    layoutCompact,
  ];

  /// Spacing

  /// Compact spacing: 12
  static const double spacingCompact = 12;

  /// Medium spacing: 12
  static const double spacingMedium = 12;

  /// Expanded spacing: 16
  static const double spacingExpanded = 16;

  /// Large spacing: 20
  static const double spacingLarge = 20;

  /// Extra Large spacing: 20
  static const double spacingExtraLarge = 20;

  /// Pane

  /// Compact pane: 0
  static const double paneCompact = 0;

  /// Medium pane: 0
  static const double paneMedium = 0;

  /// Expanded pane: 360
  static const double paneExpanded = 360;

  /// Large pane: 360
  static const double paneLarge = 360;

  /// Extra Large pane: 412
  static const double paneExtraLarge = 412;
}
