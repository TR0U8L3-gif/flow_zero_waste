import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flow_zero_waste/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

/// Onboarding repository implementation
@Singleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  /// Constructor for OnboardingRepositoryImpl
  OnboardingRepositoryImpl({
    required OnboardingLocalDataSource onboardingLocalDataSorce,
    required LoggerManager logger,
  })  : _onboardingLocalDataSorce = onboardingLocalDataSorce,
        _logger = logger;

  final OnboardingLocalDataSource _onboardingLocalDataSorce;
  final LoggerManager _logger;

  @override
  ResultFuture<Failure, bool?> loadOnboardingStatusFromStorage() async {
    try {
      _logger.trace(message: 'Getting onboarding status from local storage');

      final onboardingStatus =
          await _onboardingLocalDataSorce.loadOnboardingStatusFromStorage();

      _logger.trace(
        message: 'Received onboarding status '
            'from local storage: $onboardingStatus',
      );
      return Right(onboardingStatus);
    } catch (e, st) {
      _logger.warning(
        message: 'Error getting onboarding status from local storage: $e',
        stackTrace: st,
      );
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  ResultFuture<Failure, void> saveOnboardingStatusToStorage({
    required bool status,
  }) async {
    try {
      _logger.trace(
        message: 'Saving onboarding status ($status) to local storage',
      );

      await _onboardingLocalDataSorce.saveOnboardingStatusToStorage(
        status: status,
      );

      _logger.trace(
        message: 'Onboarding status ($status) saved to local storage',
      );

      return const Right(null);
    } catch (e, st) {
      _logger.warning(
        message: 'Error saving onboarding status to local storage: $e',
        stackTrace: st,
      );
      return Left(Failure(message: e.toString()));
    }
  }
}
