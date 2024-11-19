import 'dart:math';

import 'package:flow_zero_waste/src/profile/data/datasources/profile_data_source_exceptions.dart';
import 'package:flow_zero_waste/src/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flow_zero_waste/src/profile/data/models/profile_stats_model.dart';
import 'package:injectable/injectable.dart';

/// Profile remote data source
@Singleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ProfileStatsModel> getProfileStats() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final result = Random().nextInt(3);
    if (result == 0) {
      throw FailedToGetProfileStatsException(
        action: 'get profile stats',
        error: 'Failed to get profile stats timeout',
        stackTrace: StackTrace.current,
      );
    } else if (result == 1) {
      return const ProfileStatsModel(
        avoidedCO2eEmission: 25,
        orderCount: null,
        savedMoney: 200,
        plantedTrees: null,
        points: 1200,
      );
    } else {
      return const ProfileStatsModel(
        avoidedCO2eEmission: 25,
        orderCount: 15,
        savedMoney: 200,
        plantedTrees: 3,
        points: 1200,
      );
    }
  }
}
