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
