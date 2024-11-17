import 'package:flow_zero_waste/core/services/hive/hive.dart';
import 'package:injectable/injectable.dart';

/// Hive box name for location storage
const kLocationStorageHiveBoxName = 'location';

/// Location storage using Hive
@singleton
class LocationStorageHive extends HiveManager<String> {
  /// Constructor for LocationStorageHive
  LocationStorageHive()
      : super(
          boxName: kLocationStorageHiveBoxName,
          compactThreshold: 4,
        );

  /// Dispose method
  @disposeMethod
  void dispose() {
    closeBox();
  }  
}
