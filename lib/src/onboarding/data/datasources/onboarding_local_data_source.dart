/// Abstraction for local data source for onboarding data
abstract class OnboardingLocalDataSource {
  /// Load onboarding status from local storage
  Future<bool?> loadOnboardingStatusFromStorage();

  /// Save onboarding status to local storage
  Future<void> saveOnboardingStatusToStorage({required bool status});
}
