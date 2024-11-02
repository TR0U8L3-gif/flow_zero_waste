import 'package:flow_zero_waste/src/ui/data/models/text_scale_details_model.dart';
import 'package:flow_zero_waste/src/ui/data/models/theme_details_model.dart';

/// Abstract UI local data source
abstract class UiLocalDataSource {
  /// Save text scale model to local storage
  Future<void> saveThemeDetailsToStorage(ThemeDetailsModel themeDetails);

  /// Get text scale model from local storage
  Future<ThemeDetailsModel?> loadThemeDetailsFromStorage();

  /// Save text scale model to local storage
  Future<void> saveTextScaleDetailsToStorage(TextScaleDetailsModel textScale);

  /// Get text scale model from local storage
  Future<TextScaleDetailsModel?> loadTextScaleDetailsFromStorage();
}
