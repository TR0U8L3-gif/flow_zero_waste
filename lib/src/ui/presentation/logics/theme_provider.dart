
import 'package:flow_zero_waste/config/assets/theme/app_theme.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
/// A provider class to manage the theme of the app.
class ThemeProvider extends ChangeNotifier {
  /// Constructor to initialize the theme provider.
  ThemeProvider([ThemeMode themeMode = ThemeMode.system]) {
    brightnessFromThemeMode(themeMode);
  }

  Brightness _brightness = Brightness.light;
  Contrast _contrast = Contrast.standard;
  ThemeData _themeData = AppTheme.getThemeData(Contrast.standard, Brightness.light);

  /// Getter for the brightness.
  Brightness get brightness => _brightness;
  /// Getter for the contrast.
  Contrast get contrast => _contrast;
  /// Getter for the theme data.
  ThemeData get themeData => _themeData;

  set brightness (Brightness brightness) {
    _brightness = brightness;
    notifyListeners();
  }

  /// Method to set the brightness from the theme mode.
  void brightnessFromThemeMode(ThemeMode themeMode) {
    _brightness = themeMode.isDarkMode ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  set contrast(Contrast contrast) {
    _contrast = contrast;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    _themeData = AppTheme.getThemeData(_contrast, _brightness);
    super.notifyListeners();
  }
}
