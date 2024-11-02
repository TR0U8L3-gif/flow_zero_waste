import 'dart:async';

import 'package:flow_zero_waste/config/assets/theme/app_theme.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/theme_details.dart';
import 'package:flow_zero_waste/src/ui/domain/usecases/load_theme_from_local_storage.dart';
import 'package:flow_zero_waste/src/ui/domain/usecases/save_theme_from_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const _timerSaveDuration = 4;

/// A provider class to manage the theme of the app.
@injectable
class ThemeProvider extends ChangeNotifier {
  /// Constructor for [ThemeProvider].
  ThemeProvider({
    required LoadThemeFromLocalStorage loadThemeFromLocalStorage,
    required SaveThemeFromLocalStorage saveThemeFromLocalStorage,
  })  : _loadThemeFromLocalStorage = loadThemeFromLocalStorage,
        _saveThemeFromLocalStorage = saveThemeFromLocalStorage;

  final LoadThemeFromLocalStorage _loadThemeFromLocalStorage;
  final SaveThemeFromLocalStorage _saveThemeFromLocalStorage;

  Timer? _saveTimer;

  ThemeDetails _themeDetails = const ThemeDetails(
    brightness: Brightness.light,
    contrast: Contrast.standard,
  );

  /// Getter for the brightness.
  Brightness get brightness => _themeDetails.brightness;

  /// Getter for the contrast.
  Contrast get contrast => _themeDetails.contrast;

  /// Getter for the theme data.
  ThemeData get themeData => AppTheme.getThemeData(
        _themeDetails.contrast,
        _themeDetails.brightness,
      );

  /// Getter for the theme details.
  ThemeDetails get themeDetails => _themeDetails;

  set brightness(Brightness brightness) {
    _themeDetails = _themeDetails.copyWith(brightness: brightness);
    notifyListeners();
    _save();
  }

  /// Method set the contrast from the contrast enum.
  set contrast(Contrast contrast) {
    _themeDetails = _themeDetails.copyWith(contrast: contrast);
    notifyListeners();
    _save();
  }

  /// Method to load the theme details.
  void loadThemeDetails() {
    _loadThemeFromLocalStorage(const NoParams()).then(
      (result) => result.fold(
        (failure) => null,
        (success) {
          if (success != null) {
            _themeDetails = success;
            notifyListeners();
          }
        },
      ),
    );
  }

  /// Method to save the theme details.
  void saveThemeDetails() {
    _saveThemeFromLocalStorage(
      SaveThemeFromLocalStorageParams(themeDetails: _themeDetails),
    );
  }

  void _clearTimer() {
    if (_saveTimer != null) {
      _saveTimer!.cancel();
      _saveTimer = null;
    }
  }

  void _save() {
    _clearTimer();
    _saveTimer = Timer(
      const Duration(seconds: _timerSaveDuration),
      saveThemeDetails,
    );
  }

}
