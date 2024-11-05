import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// L10n is a class that holds the localization variables for the app.
class L10n {
  /// Returns the supported delegate for the given locale.
  static const supportedDelegates = AppLocalizations.localizationsDelegates;

  /// Returns the supported delegate for the given locale.
  static const supportedLocales = AppLocalizations.supportedLocales;

  /// Returns the supported locale for the given locale.
  static Locale? isSupported(Locale locale) {
    return supportedLocales
        .firstWhereOrNull((supportedLocale) => locale == supportedLocale);
  }

  /// Returns the supported locale for the given language code.
  static Locale? isSupportedLanguageCode(String languageCode) {
    return supportedLocales
        .firstWhereOrNull((locale) => locale.languageCode == languageCode);
  }
}
