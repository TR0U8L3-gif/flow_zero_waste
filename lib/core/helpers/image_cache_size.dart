import 'package:flutter/material.dart';

/// Image cache size
class ImageCacheSize {
  /// Default image cache size
  static int calculateDefault = 250;
  /// Calculate the image cache size
  static int calculate(BuildContext context, double size) {
    if (!context.mounted) return calculateDefault;
    return (size * MediaQuery.of(context).devicePixelRatio).round();
  }
}
