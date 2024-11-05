
import 'package:flow_zero_waste/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flow_zero_waste/src/onboarding/data/datasources/onboarding_storage_hive.dart';
import 'package:injectable/injectable.dart';

/// Onboarding 
const String onboardingKey = 'onboarding';

/// Onboarding local data storage implementation
@Singleton(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource{
  // ignore: public_member_api_docs
  const OnboardingLocalDataSourceImpl({
    required OnboardingStorageHive onboardingStorageHive,
  }) : _onboardingStorageHive = onboardingStorageHive;

  final OnboardingStorageHive _onboardingStorageHive;

  @override
  Future<bool?> loadOnboardingStatusFromStorage() {
    return _onboardingStorageHive.read(key: onboardingKey);
  }

  @override
  Future<void> saveOnboardingStatusToStorage({required bool status}) {
    return _onboardingStorageHive.write(status, key: onboardingKey);
  }
}
