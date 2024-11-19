import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/profile/data/datasources/profile_data_source_exceptions.dart';
import 'package:flow_zero_waste/src/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flow_zero_waste/src/profile/data/mappers/profile_stats_mapper.dart';
import 'package:flow_zero_waste/src/profile/domain/entities/profile_stats.dart';
import 'package:flow_zero_waste/src/profile/domain/repositories/profile_repository.dart';
import 'package:flow_zero_waste/src/profile/domain/responses/profile_responses.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

/// Profile repository implementation
@Singleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  /// Default constructor
  ProfileRepositoryImpl({
    required ProfileStatsMapper profileStatsMapper,
    required LoggerManager loggerManager,
    required ProfileRemoteDataSource profileRemoteDataSource,
  })  : _profileStatsMapper = profileStatsMapper,
        _logger = loggerManager,
        _profileRemoteDataSource = profileRemoteDataSource;

  final ProfileStatsMapper _profileStatsMapper;
  final LoggerManager _logger;
  final ProfileRemoteDataSource _profileRemoteDataSource;

  @override
  ResultFuture<Failure, ProfileStats> getProfileStats() async {
    try {
      final result = await _profileRemoteDataSource.getProfileStats();
      final profileStats = _profileStatsMapper.from(result);
      return Right(profileStats);
    } on FailedToGetProfileStatsException catch (e, st) {
      _logger.warning(
        message: 'Unable to get profile stats',
        error: e.error,
        stackTrace: st,
      );
      return const Left(FailedToGetProfileStatsFailure());
    } catch (e, st) {
      _logger.error(
        message: 'Unable to get profile stats',
        error: e,
        stackTrace: st,
      );
      return const Left(
        Failure(
          message: 'Unable to get profile stats',
        ),
      );
    }
  }
}
