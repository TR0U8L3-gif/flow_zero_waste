import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

/// Save onboarding seen use case
@singleton
class SaveOnboardingSeenToLocalStorage
    extends UseCase<void, SaveOnboardingSeenToLocalStorageParams> {
  /// Constructor for SaveOnboardingSeenFromLocalStorage
  SaveOnboardingSeenToLocalStorage({required OnboardingRepository repository})
      : _repository = repository;
  final OnboardingRepository _repository;

  @override
  ResultFuture<Failure, void> call(
    SaveOnboardingSeenToLocalStorageParams params,
  ) {
    return _repository.saveOnboardingStatusToStorage(status: params.status);
  }
}

/// Parameters for SaveOnboardingSeenToLocalStorage
class SaveOnboardingSeenToLocalStorageParams {
  /// Constructor for SaveOnboardingSeenToLocalStorageParams
  SaveOnboardingSeenToLocalStorageParams({required this.status});

  /// Onboarding status
  final bool status;
}
