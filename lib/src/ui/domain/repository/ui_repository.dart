import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/text_scale_details.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/theme_details.dart';

/// Abstract UI repository
abstract class UiRepository {
  /// Save text scale details entity to local storage
  ResultFuture<Failure, void> saveTextScaleDetailsToStorage(
    TextScaleDetails textScale,
  );

  /// Get text scale details entity from local storage
  ResultFuture<Failure, TextScaleDetails?> loadTextScaleDetailsFromStorage();

  /// Save theme details entity to local storage
  ResultFuture<Failure, void> saveThemeDetailsToStorage(
    ThemeDetails themeDetails,
  );

  /// Get theme details entity from local storage
  ResultFuture<Failure, ThemeDetails?> loadThemeDetailsFromStorage();
}
