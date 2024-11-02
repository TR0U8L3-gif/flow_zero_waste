import 'package:equatable/equatable.dart';

/// Entity class that store the text scale factor data.
class TextScaleDetails extends Equatable {
  /// Constructor for [TextScaleDetails].
  const TextScaleDetails({
    required this.textScaleFactor,
    required this.textScaleFactorMin,
    required this.textScaleFactorMax,
  });

  /// Text scale factor.
  final double textScaleFactor;

  /// Minimum text scale factor.
  final double textScaleFactorMin;

  /// Maximum text scale factor.
  final double textScaleFactorMax;

  @override
  List<Object?> get props => [
        textScaleFactor,
        textScaleFactorMin,
        textScaleFactorMax,
      ];

  /// Copy existing [TextScaleDetails] with new values.
  TextScaleDetails copyWith({
    double? textScaleFactor,
    double? textScaleFactorMin,
    double? textScaleFactorMax,
  }) {
    return TextScaleDetails(
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textScaleFactorMin: textScaleFactorMin ?? this.textScaleFactorMin,
      textScaleFactorMax: textScaleFactorMax ?? this.textScaleFactorMax,
    );
  }
}
