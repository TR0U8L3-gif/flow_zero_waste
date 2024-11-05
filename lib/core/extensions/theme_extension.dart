import 'package:flutter/material.dart';

/// ThemeExtension is a class that extends the BuildContext class
extension ThemeExtension on BuildContext {
  /// ThemeData getter
  ThemeData get theme => Theme.of(this);
  /// ColorScheme getter
  ColorScheme get colorScheme => theme.colorScheme;
  /// TextTheme getter
  TextTheme get textTheme => theme.textTheme;
}

/// BrightnessExtension is a class that extends the Brightness class
extension BrightnessExtension on Brightness {
  /// isDark getter
  bool get isDark {
    return this == Brightness.dark;
  }

  /// isLight getter
  bool get isLight {
    return this == Brightness.light;
  }
}

/// ThemeModeExtension is a class that extends the ThemeMode class
extension ThemeModeExtension on ThemeMode {
  /// isDarkMode getter
  bool get isDarkMode {
    return this == ThemeMode.dark;
  }

  /// isLightMode getter
  bool get isLightMode {
    return this == ThemeMode.light;
  }
}
