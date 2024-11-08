import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Register user use case
@singleton
class RegisterUser extends UseCase<void, RegisterUserParams> {
  /// Register user use case constructor
  RegisterUser({required AuthRepository repository}) : _repository = repository;
  final AuthRepository _repository;

  @override
  ResultFuture<Failure, void> call(RegisterUserParams params) {
    return _repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      phoneNumber: params.phoneNumber,
    );
  }
}

/// Register user params
class RegisterUserParams {
  /// Register user params constructor
  RegisterUserParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  /// Name
  final String name;

  /// Email
  final String email;

  /// Password
  final String password;

  /// Phone number
  final String phoneNumber;
}
