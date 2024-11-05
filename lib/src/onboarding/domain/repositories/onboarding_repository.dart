import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';

/// abstract Onboarding repository
abstract class OnboardingRepository {
  /// Save onboarding status to local storage
  ResultFuture<Failure, void> saveOnboardingStatusToStorage({
    required bool status,
  });

  /// Get onboarding status from local storage
  ResultFuture<Failure, bool?> loadOnboardingStatusFromStorage();
}
