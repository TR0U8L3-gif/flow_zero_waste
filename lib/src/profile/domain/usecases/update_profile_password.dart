import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

/// Update profile password use case
@singleton
class UpdateProfilePassword
    extends UseCase<Success, UpdateProfilePasswordParams> {
  /// Default constructor
  UpdateProfilePassword({required ProfileRepository repository})
      : _repository = repository;
  final ProfileRepository _repository;

  @override
  ResultFuture<Failure, Success> call(UpdateProfilePasswordParams params) {
    return _repository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }
}

/// Update profile password params
class UpdateProfilePasswordParams {
  /// Default constructor
  UpdateProfilePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });

  /// Current password
  final String currentPassword;

  /// New password
  final String newPassword;
}
