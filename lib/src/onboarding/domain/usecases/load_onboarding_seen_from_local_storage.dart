import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

/// Load onboarding seen use case
@singleton
class LoadOnboardingSeenFromLocalStorage extends UseCase<bool?, NoParams> {
  /// Constructor for LoadOnboardingSeenFromLocalStorage
  LoadOnboardingSeenFromLocalStorage({required OnboardingRepository repository})
      : _repository = repository;
  final OnboardingRepository _repository;

  @override
  ResultFuture<Failure, bool?> call(NoParams params) {
    return _repository.loadOnboardingStatusFromStorage();
  }
}
