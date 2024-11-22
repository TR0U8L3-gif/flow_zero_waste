import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/profile/domain/entities/profile_stats.dart';

/// Profile repository
abstract class ProfileRepository {
  /// Get profile stats
  ResultFuture<Failure, ProfileStats> getProfileStats();

  /// Update profile data
  ResultFuture<Failure, Success> updateProfileData({
    required String? name,
    required String? email,
    required String? phoneNumber,
  });

  /// Change password
  ResultFuture<Failure, Success> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
