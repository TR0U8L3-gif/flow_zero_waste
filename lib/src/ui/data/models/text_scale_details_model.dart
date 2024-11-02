import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';

/// Model class that store the text scale factor data.
class TextScaleDetailsModel extends Equatable {
  /// Constructor for [TextScaleDetailsModel].
  const TextScaleDetailsModel({
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

  /// Converts the JSON object to a [TextScaleDetailsModel].
  factory TextScaleDetailsModel.fromJson(DataMap json) {
    return TextScaleDetailsModel(
      textScaleFactor: json['textScaleFactor'] as double,
      textScaleFactorMin: json['textScaleFactorMin'] as double,
      textScaleFactorMax: json['textScaleFactorMax'] as double,
    );
  }

  /// Converts the [TextScaleDetailsModel] to a JSON object.
  DataMap toJson() {
    return <String, dynamic>{
      'textScaleFactor': textScaleFactor,
      'textScaleFactorMin': textScaleFactorMin,
      'textScaleFactorMax': textScaleFactorMax,
    };
  }

  @override
  List<Object?> get props => [
        textScaleFactor,
        textScaleFactorMin,
        textScaleFactorMax,
      ];
}
