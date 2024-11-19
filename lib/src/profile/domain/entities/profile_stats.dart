import 'package:equatable/equatable.dart';

/// Profile stats
class ProfileStats extends Equatable {
  /// Default constructor
  const ProfileStats({
    required this.avoidedCO2eEmission,
    required this.savedMoney,
    required this.orderCount,
    required this.points,
    required this.plantedTrees,
  });

  /// Empty ProfileStats
  factory ProfileStats.empty() {
    return const ProfileStats(
      avoidedCO2eEmission: null,
      orderCount: null,
      plantedTrees: null,
      points: null,
      savedMoney: null,
    );
  }

  /// Avoided CO2e emission
  final double? avoidedCO2eEmission;

  /// Saved money
  final double? savedMoney;

  /// Order count
  final double? orderCount;

  /// Points
  final double? points;

  /// Planted trees
  final double? plantedTrees;

  /// Copy with
  ProfileStats copyWith({
    double? Function()? avoidedCO2eEmission,
    double? Function()? savedMoney,
    double? Function()? orderCount,
    double? Function()? points,
    double? Function()? plantedTrees,
  }) {
    return ProfileStats(
      avoidedCO2eEmission: avoidedCO2eEmission != null
          ? avoidedCO2eEmission.call()
          : this.avoidedCO2eEmission,
      savedMoney: savedMoney != null ? savedMoney.call() : this.savedMoney,
      orderCount: orderCount != null ? orderCount.call() : this.orderCount,
      points: points != null ? points.call() : this.points,
      plantedTrees:
          plantedTrees != null ? plantedTrees.call() : this.plantedTrees,
    );
  }

  @override
  List<Object?> get props =>
      [avoidedCO2eEmission, savedMoney, orderCount, points, plantedTrees];
}
