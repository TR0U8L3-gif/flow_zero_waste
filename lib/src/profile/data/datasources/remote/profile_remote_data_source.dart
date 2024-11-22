import 'package:flow_zero_waste/src/profile/data/models/profile_stats_model.dart';

/// Profile remote data source
abstract class ProfileRemoteDataSource {
  /// Get profile stats
  Future<ProfileStatsModel> getProfileStats();

  /// Update profile data
  Future<void> updateProfileData({
    required String? name,
    required String? email,
    required String? phoneNumber,
  });

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
