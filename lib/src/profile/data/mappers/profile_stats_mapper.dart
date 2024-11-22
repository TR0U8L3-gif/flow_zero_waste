import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/profile/data/models/profile_stats_model.dart';
import 'package:flow_zero_waste/src/profile/domain/entities/profile_stats.dart';
import 'package:injectable/injectable.dart';

/// Profile stats mapper
@singleton
class ProfileStatsMapper implements Mapper<ProfileStatsModel, ProfileStats> {
  @override
  ProfileStats from(ProfileStatsModel object) {
    return ProfileStats(
      avoidedCO2eEmission: object.avoidedCO2eEmission,
      orderCount: object.orderCount,
      savedMoney: object.savedMoney,
      plantedTrees: object.plantedTrees,
      points: object.points,
    );
  }

  @override
  ProfileStatsModel to(ProfileStats object) {
    return ProfileStatsModel(
      avoidedCO2eEmission: object.avoidedCO2eEmission,
      orderCount: object.orderCount,
      savedMoney: object.savedMoney,
      plantedTrees: object.plantedTrees,
      points: object.points,
    );
  }  
}
