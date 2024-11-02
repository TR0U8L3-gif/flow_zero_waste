import 'package:flutter/material.dart';

/// BuildContextExtension is a class that extends the BuildContext class
extension BuildContextExtension on BuildContext{
  /// MediaQueryData getter
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Size getter
  Size get size => mediaQuery.size;

  /// Width getter
  double get width => size.width;

  /// Height getter
  double get height => size.height;
}
