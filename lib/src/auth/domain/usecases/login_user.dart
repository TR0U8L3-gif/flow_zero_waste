import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/auth/domain/entities/user.dart';
import 'package:flow_zero_waste/src/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Login user use case
@singleton
class LoginUser extends UseCase<User,LoginUserParams> {
  /// Login user use case constructor
  LoginUser({required AuthRepository repository}) : _repository = repository;
  final AuthRepository _repository;

  @override
  ResultFuture<Failure, User> call(LoginUserParams params) {
    return _repository.login(email: params.email, password: params.password);
  }
  
}

/// Login user params
class LoginUserParams {
  /// Login user params constructor
  LoginUserParams({required this.email, required this.password});
  /// Email
  final String email;
  /// Password
  final String password;
}
