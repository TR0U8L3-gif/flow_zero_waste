import 'dart:convert';

import 'package:flow_zero_waste/core/common/data/exceptions.dart';
import 'package:flow_zero_waste/src/ui/data/datasource/ui_local_data_source.dart';
import 'package:flow_zero_waste/src/ui/data/datasource/ui_storage_hive.dart';
import 'package:flow_zero_waste/src/ui/data/models/text_scale_details_model.dart';
import 'package:flow_zero_waste/src/ui/data/models/theme_details_model.dart';
import 'package:injectable/injectable.dart';

/// Text Scale Details key used for hive storage
const String textScaleDetailsKey = 'textScaleDetails';

/// Theme Details key used for hive storage
const String themeDetailsKey = 'themeDetails';

/// Ui local data source implementation
@Singleton(as: UiLocalDataSource)
class UiLocalDataSourceImpl implements UiLocalDataSource {
  /// Constructor for UiLocalDataSourceImpl
  UiLocalDataSourceImpl({
    required UiStorageHive uiStorageHive,
  }) : _uiStorageHive = uiStorageHive;
  final UiStorageHive _uiStorageHive;

  @override
  Future<TextScaleDetailsModel?> loadTextScaleDetailsFromStorage() async {
    final data = await _uiStorageHive.read(key: textScaleDetailsKey);

    print('data: $data');

    if (data == null) {
      return null;
    }
    try {
      final dataMap = json.decode(data) as Map<String, dynamic>;
      return TextScaleDetailsModel.fromJson(dataMap);
    } catch (e, st) {
      throw LocalStorageException(
        sender: e.toString(),
        description: 'decode string to map => fromJson',
        stackTrace: st,
      );
    }
  }

  @override
  Future<ThemeDetailsModel?> loadThemeDetailsFromStorage() async {
    final data = await _uiStorageHive.read(key: themeDetailsKey);
    if (data == null) {
      return null;
    }
    try {
      final dataMap = json.decode(data) as Map<String, dynamic>;
      return ThemeDetailsModel.fromJson(dataMap);
    } catch (e, st) {
      throw LocalStorageException(
        sender: e.toString(),
        description: 'decode string to map => fromJson',
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> saveTextScaleDetailsToStorage(
    TextScaleDetailsModel textScale,
  ) async {
    try {
      final data = json.encode(textScale.toJson());
      await _uiStorageHive.write(data, key: textScaleDetailsKey);
    } catch (e, st) {
      throw LocalStorageException(
        sender: e.toString(),
        description: 'encode map to string => write',
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> saveThemeDetailsToStorage(
    ThemeDetailsModel themeDetails,
  ) {
    try {
      final data = json.encode(themeDetails.toJson());
      return _uiStorageHive.write(data, key: themeDetailsKey);
    } catch (e, st) {
      throw LocalStorageException(
        sender: e.toString(),
        description: 'encode map to string => write',
        stackTrace: st,
      );
    }
  }
}
