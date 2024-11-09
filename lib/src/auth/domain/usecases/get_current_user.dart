import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/auth/domain/entities/user.dart';
import 'package:flow_zero_waste/src/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Get current user use case
@singleton
class GetCurrentUser extends UseCase<User?, NoParams> {
  /// Get current user use case constructor
  GetCurrentUser({required AuthRepository repository})
      : _repository = repository;
  final AuthRepository _repository;

  @override
  ResultFuture<Failure, User?> call(NoParams params) {
    return _repository.getCurrentUser();
  }
}
