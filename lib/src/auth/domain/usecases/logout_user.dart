import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Logout user use case
@singleton
class LogoutUser extends UseCase<void,NoParams> {
  /// Logout user use case constructor
  LogoutUser({required AuthRepository repository}) : _repository = repository;
  final AuthRepository _repository;

  @override
  ResultFuture<Failure, void> call(NoParams params) {
    return _repository.logout();
  }
  
}
