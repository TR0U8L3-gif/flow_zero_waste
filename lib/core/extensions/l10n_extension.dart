import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Localization extension
extension L10nExtension on BuildContext {
  /// Get the current locale
  Locale get locale => Localizations.localeOf(this);
  /// Get the current language tag
  String get languageCode => locale.languageCode;
  /// Get the current localization
  AppLocalizations get l10n =>
      AppLocalizations.of(this);
}
