import 'package:flow_zero_waste/config/assets/theme/app_color_scheme.dart';
import 'package:flow_zero_waste/config/assets/theme/app_text_theme.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flutter/material.dart';

/// Class to define the app theme
class AppTheme {
  AppTheme._();

  /// Theme data
  static ThemeData getThemeData(Contrast mode, Brightness brightness) {
    final colorScheme = AppColorScheme.getColorScheme(mode, brightness);
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      textTheme: AppTextTheme.getTextTheme(mode, brightness),
    );
  }
}
