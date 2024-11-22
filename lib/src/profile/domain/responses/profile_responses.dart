import 'package:flow_zero_waste/core/common/domain/response.dart';

/// Profile Failure
sealed class ProfileFailure extends Failure{
  /// Default constructor
  const ProfileFailure();
}

/// Failed to get profile stats failure
class FailedToGetProfileStatsFailure extends ProfileFailure {
  /// Default constructor
  const FailedToGetProfileStatsFailure();
}

/// Failed to update profile data failure
class FailedToUpdateProfileDataFailure extends ProfileFailure {
  /// Default constructor
  const FailedToUpdateProfileDataFailure();
}

/// Failed to change password failure
class FailedToChangePasswordFailure extends ProfileFailure {
  /// Default constructor
  const FailedToChangePasswordFailure();
}

/// Profile Success
sealed class ProfileSuccess extends Success{
  /// Default constructor
  const ProfileSuccess();
}

/// Updated profile data Success
class UpdatedProfileDataSuccess extends ProfileSuccess {
  /// Default constructor
  const UpdatedProfileDataSuccess();
}

/// Changed password Success
class ChangedPasswordSuccess extends ProfileSuccess {
  /// Default constructor
  const ChangedPasswordSuccess();
}
