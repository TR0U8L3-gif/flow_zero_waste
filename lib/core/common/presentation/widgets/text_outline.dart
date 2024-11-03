import 'package:flutter/material.dart';

/// Text with outline
class TextOutline extends StatelessWidget {
  /// Default constructor
  const TextOutline({
    required this.text,
    required this.strokeWidth,
    required this.strokeColor,
    this.textStyle,
    super.key,
  });

  /// Text
  final String text;
  /// Text style
  final TextStyle? textStyle;
  /// Stroke width
  final double strokeWidth;
  /// Stroke color
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: textStyle?.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
