import 'package:flow_zero_waste/core/services/hive/hive.dart';
import 'package:injectable/injectable.dart';

/// Hive box name for onboarding storage
const kOnboardingStorageHiveBoxName = 'onboarding';

/// Onboarding storage using Hive
@singleton
class OnboardingStorageHive extends HiveManager<bool> {
  /// Constructor for OnboardingStorageHive
  OnboardingStorageHive()
      : super(
          boxName: kOnboardingStorageHiveBoxName,
          compactThreshold: 4,
        );

  /// Dispose method
  @disposeMethod
  void dispose() {
    closeBox();
  }  
}
