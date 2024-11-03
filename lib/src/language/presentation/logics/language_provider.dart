import 'dart:ui';

import 'package:flow_zero_waste/config/l10n/l10n.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/constants/language_constant.dart';
import 'package:flow_zero_waste/src/language/domain/usecases/load_language_from_local_storage.dart';
import 'package:flow_zero_waste/src/language/domain/usecases/save_language_to_local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

/// Language cubit
@singleton
class LanguageProvider extends ChangeNotifier {
  /// Default constructor
  LanguageProvider({
    required LoadLanguageFromLocalStorage getLanguageFromStorage,
    required SaveLanguageToLocalStorage saveLanguageToStorage,
  })  : _loadLanguageFromStorage = getLanguageFromStorage,
        _saveLanguageToStorage = saveLanguageToStorage;

  final LoadLanguageFromLocalStorage _loadLanguageFromStorage;
  final SaveLanguageToLocalStorage _saveLanguageToStorage;

  var _currentLanguage = const Locale(kLanguageCodeDefault);

  /// Getter for the current language
  Locale get currentLanguage => _currentLanguage;

  /// Change the language
  void changeLanguage(String languageCode) {
    final newLanguage = L10n.isSupportedLanguageCode(languageCode);
    if (newLanguage != null && _currentLanguage != newLanguage) {
      _saveLanguage(newLanguage);
      _updateLanguage(newLanguage);
    }
  }

  /// Save the selected language to the local storage
  void _saveLanguage(Locale locale) {
    _saveLanguageToStorage
        .call(SaveLanguageToStorageParams(languageCode: locale.languageCode));
  }

  /// Load the language from the local storage
  Future<void> loadLanguageOrSetDeviceLocale() async {
    final result = await _loadLanguageFromStorage.call(const NoParams());
    result.fold(
      (failure) {},
      (languageCode) {
        // if language code is null, set the device locale
        // otherwise set the language code from the local storage
        final newLanguage = L10n.isSupportedLanguageCode(
          languageCode ?? PlatformDispatcher.instance.locale.languageCode,
        );

        if (newLanguage != null) {
          _updateLanguage(newLanguage);
        }
      },
    );
  }

  void _updateLanguage(Locale locale) {
    if (_currentLanguage == locale) {
      return;
    }
    _currentLanguage = locale;
    notifyListeners();
  }
}
