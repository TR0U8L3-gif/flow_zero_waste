import 'package:flow_zero_waste/core/common/data/exceptions.dart';

/// Failed to get profile stats exception
class FailedToGetProfileStatsException extends BaseException {
  /// Default constructor
  const FailedToGetProfileStatsException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// Failed to update profile data exception
class FailedToUpdateProfileDataException extends BaseException {
  /// Default constructor
  const FailedToUpdateProfileDataException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// Failed to change password exception
class FailedToChangePasswordException extends BaseException {
  /// Default constructor
  const FailedToChangePasswordException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}
