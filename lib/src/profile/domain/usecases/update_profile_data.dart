import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

/// Update profile data use case
@singleton
class UpdateProfileData extends UseCase<Success, UpdateProfileDataParams> {
  /// Default constructor
  UpdateProfileData({required ProfileRepository repository})
      : _repository = repository;
  final ProfileRepository _repository;

  @override
  ResultFuture<Failure, Success> call(UpdateProfileDataParams params) {
    return _repository.updateProfileData(
      email: params.email,
      name: params.name,
      phoneNumber: params.phoneNumber,
    );
  }
}

/// Update profile data params
class UpdateProfileDataParams {
  /// Default constructor
  UpdateProfileDataParams({
    this.name,
    this.email,
    this.phoneNumber,
  });

  /// Name
  final String? name;

  /// Email
  final String? email;

  /// Phone number
  final String? phoneNumber;
}
