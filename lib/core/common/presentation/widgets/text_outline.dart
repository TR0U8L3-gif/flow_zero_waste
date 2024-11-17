import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/extensions/num_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Text with outline
class TextOutline extends StatelessWidget {
  /// Default constructor
  const TextOutline(
    this.text, {
    this.strokeWidth,
    this.strokeColor,
    this.style,
    this.maxLines,
    this.overflow,
    super.key,
  });

  /// Text
  final String text;

  /// Text style
  final TextStyle? style;

  /// Stroke width
  final double? strokeWidth;

  /// Stroke color
  final Color? strokeColor;

  /// Max lines
  final int? maxLines;

  /// Text overflow
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style?.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth ?? AppSize.s2
              ..color = strokeColor ??
                  context.colorScheme.surface
                      .withOpacity(AppSize.xxxl.fraction),
          ),
          maxLines: maxLines,
          overflow: overflow,
        ),
        Text(
          text,
          style: style,
          maxLines: maxLines,
          overflow: overflow,
        ),
      ],
    );
  }
}
