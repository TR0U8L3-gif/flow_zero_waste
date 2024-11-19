import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/profile/domain/entities/profile_stats.dart';
import 'package:flow_zero_waste/src/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

/// Get profile stats use case
@singleton
class GetProfileStats extends UseCase<ProfileStats,NoParams> {
  /// Default constructor
  GetProfileStats({required ProfileRepository repository}) : _repository = repository;
  final ProfileRepository _repository;

  @override
  ResultFuture<Failure, ProfileStats> call(NoParams params) {
    return _repository.getProfileStats();
  }
  
}
