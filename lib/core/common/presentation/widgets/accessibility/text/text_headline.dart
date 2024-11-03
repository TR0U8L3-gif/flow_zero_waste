import 'package:flow_zero_waste/core/enums/text_enum.dart';
import 'package:flutter/material.dart';

/// A headline text widget with semantics.
class TextHeadline extends StatelessWidget {
  /// Creates a headline text widget.
  const TextHeadline(
    this.data, {
    required this.textSize, 
    required this.headingLevel, 
    super.key,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    @Deprecated(
      'Use textScaler instead. Use of textScaleFactor was deprecated '
      'in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  })  :
        assert(
          textScaler == null || textScaleFactor == null,
          'textScaleFactor is deprecated and cannot be specified '
          'when textScaler is specified.',
        );

  /// The text to display.
  final String data;

  /// The size of the text.
  final TextSize textSize;

  /// The heading level of the text.
  final HeadingLevel headingLevel;

  /// The strut style of the text.
  final StrutStyle? strutStyle;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// The direction of the text.
  final TextDirection? textDirection;

  /// The locale of the text.
  final Locale? locale;

  /// Whether the text should wrap.
  final bool? softWrap;

  /// The overflow of the text.
  final TextOverflow? overflow;

  @Deprecated(
    'Use textScaler instead. '
    'Use of textScaleFactor was deprecated in preparation for '
    'the upcoming nonlinear text scaling support. '
    'This feature was deprecated after v3.12.0-2.0.pre.',
  )
  /// The scale factor of the text.
  final double? textScaleFactor;

  /// The scaler of the text.
  final TextScaler? textScaler;

  /// The maximum number of lines for the text.
  final int? maxLines;

  /// The semantics label of the text.
  final String? semanticsLabel;

  /// The width basis of the text.
  final TextWidthBasis? textWidthBasis;

  /// The height behavior of the text.
  final TextHeightBehavior? textHeightBehavior;

  /// The selection color of the text.
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      headingLevel: headingLevel.value,
      header: true,
      child: Text(
        data,
        style: _styleFromSize(context, textSize),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        // ignore: deprecated_member_use, deprecated_member_use_from_same_package
        textScaleFactor: textScaleFactor,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }

  TextStyle? _styleFromSize(BuildContext context, TextSize size) {
    final theme = Theme.of(context).textTheme;
    switch (size) {
      case TextSize.large:
      return theme.headlineLarge;
      case TextSize.medium:
      return theme.headlineMedium;
      case TextSize.small:
      return theme.headlineSmall;
    }
  }
}
