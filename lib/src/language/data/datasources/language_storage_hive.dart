import 'package:flow_zero_waste/core/services/hive/hive_manager.dart';
import 'package:injectable/injectable.dart';

/// Hive box name for language storage
const kLanguageStorageHiveBoxName = 'language';

/// Language storage using Hive
@singleton
class LanguageStorageHive extends HiveManager<String> {
  /// Constructor for LanguageStorageHive
  LanguageStorageHive()
      : super(
          boxName: kLanguageStorageHiveBoxName,
          compactThreshold: 20,
        );

  /// Dispose method
  @disposeMethod
  void dispose() {
    closeBox();
  }
}
