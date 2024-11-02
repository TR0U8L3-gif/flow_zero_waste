import 'package:flow_zero_waste/core/services/hive/hive_manager.dart';
import 'package:injectable/injectable.dart';

/// Hive box name for ui storage
const kUiStorageHiveBoxName = 'ui';

/// Language storage using Hive
@singleton
class UiStorageHive extends HiveManager<String> {
  /// Constructor for LanguageStorageHive
  UiStorageHive()
      : super(
          boxName: kUiStorageHiveBoxName,
          compactThreshold: 20,
        );

  /// Dispose method
  @disposeMethod
  void dispose() {
    closeBox();
  }
}
