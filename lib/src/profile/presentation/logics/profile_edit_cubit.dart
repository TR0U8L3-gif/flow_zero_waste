import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/profile/domain/usecases/update_profile_data.dart';
import 'package:flow_zero_waste/src/profile/domain/usecases/update_profile_password.dart';
import 'package:injectable/injectable.dart';

part 'profile_edit_state.dart';

/// Profile edit cubit
@injectable
class ProfileEditCubit extends Cubit<ProfileEditState> {
  /// Default constructor
  ProfileEditCubit({
    required UpdateProfileData updateProfileData,
    required UpdateProfilePassword updateProfilePassword,
  })  : _updateProfileData = updateProfileData,
        _updateProfilePassword = updateProfilePassword,
        super(const ProfileEditIdle());

  final UpdateProfileData _updateProfileData;
  final UpdateProfilePassword _updateProfilePassword;

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(
      const ProfileEditLoading(
        isDataChanged: false,
        isPasswordChanged: true,
      ),
    );

    final result = await _updateProfilePassword.call(
      UpdateProfilePasswordParams(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );

    result.fold(
      (failure) {
        emit(ProfileEditFailure(failure: failure));
      },
      (success) {
        emit(ProfileEditSuccess(success: success));
      },
    );

    emit(const ProfileEditIdle());
  }

  /// Change profile data
  Future<void> changeProfileData({
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    emit(
      const ProfileEditLoading(
        isDataChanged: true,
        isPasswordChanged: false,
      ),
    );

    final result = await _updateProfileData.call(
      UpdateProfileDataParams(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
      ),
    );

    result.fold(
      (failure) {
        emit(ProfileEditFailure(failure: failure));
      },
      (success) {
        emit(ProfileEditSuccess(success: success));
      },
    );

    emit(const ProfileEditIdle());
  }
}
