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
