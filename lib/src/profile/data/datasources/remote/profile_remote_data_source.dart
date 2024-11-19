import 'package:flow_zero_waste/src/profile/data/models/profile_stats_model.dart';

/// Profile remote data source
abstract class ProfileRemoteDataSource {
  /// Get profile stats
  Future<ProfileStatsModel> getProfileStats();
}
