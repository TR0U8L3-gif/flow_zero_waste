import 'package:flutter/material.dart';

/// Text extension
extension TextExtension on Text {
  /// Calculate the size of the text
  Size get size {
    final textSpan = TextSpan(
      text: data,
      style: style,
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: maxLines,
      textDirection: textDirection ?? TextDirection.ltr,
    )..layout();

    return Size(textPainter.width, textPainter.height);
  }

  /// Calculate the size of the text with the given parameters
  Size calculateSize({
    required int maxLines,
    TextDirection? textDirection,
    TextScaler? textScaler,
  }) {
    final textSpan = TextSpan(
      text: data,
      style: style,
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: maxLines,
      textScaler: textScaler ?? TextScaler.noScaling,
      textDirection: textDirection ?? (this.textDirection ?? TextDirection.ltr),
    )..layout();

    return Size(textPainter.width, textPainter.height);
  }
}
