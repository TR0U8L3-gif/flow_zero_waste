import 'package:collection/collection.dart';
import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flow_zero_waste/src/ui/data/models/theme_details_model.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/theme_details.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Mapper class from [ThemeDetailsModel] to [ThemeDetails].
@singleton
class ThemeDetailsMapper implements Mapper<ThemeDetailsModel, ThemeDetails> {
  @override
  ThemeDetails from(ThemeDetailsModel object) {
    final brightness = Brightness.values.firstWhereOrNull(
          (element) =>
              element.name.toLowerCase() == object.brightness.toLowerCase(),
        ) ??
        Brightness.light;

    final contrast = Contrast.values.firstWhereOrNull(
          (element) =>
              element.name.toLowerCase() == object.contrast.toLowerCase(),
        ) ??
        Contrast.standard;

    return ThemeDetails(
      brightness: brightness,
      contrast: contrast,
    );
  }

  @override
  ThemeDetailsModel to(ThemeDetails object) {
    return ThemeDetailsModel(
      brightness: object.brightness.name,
      contrast: object.contrast.name,
    );
  }
}
