import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/ui/data/models/text_scale_details_model.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/text_scale_details.dart';
import 'package:injectable/injectable.dart';

/// Mapper class from [TextScaleDetailsModel] to [TextScaleDetails].
@singleton
class TextScaleDetailsMapper
    extends Mapper<TextScaleDetailsModel, TextScaleDetails> {
  @override
  TextScaleDetails from(TextScaleDetailsModel object) {
    return TextScaleDetails(
      textScaleFactor: object.textScaleFactor,
      textScaleFactorMin: object.textScaleFactorMin,
      textScaleFactorMax: object.textScaleFactorMax,
    );
  }

  @override
  TextScaleDetailsModel to(TextScaleDetails object) {
    return TextScaleDetailsModel(
      textScaleFactor: object.textScaleFactor,
      textScaleFactorMin: object.textScaleFactorMin,
      textScaleFactorMax: object.textScaleFactorMax,
    );
  }
}
