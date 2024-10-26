import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static const supportedDelegates = AppLocalizations.localizationsDelegates;

  static const supportedLocales = AppLocalizations.supportedLocales;

  static Locale? isSupported(Locale locale) {
    return supportedLocales
        .firstWhereOrNull((supportedLocale) => locale == supportedLocale);
  }

  static Locale? isSupportedLanguageCode(String languageCode) {
    return supportedLocales
        .firstWhereOrNull((locale) => locale.languageCode == languageCode);
  }
}
