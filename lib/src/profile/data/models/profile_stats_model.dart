import 'package:equatable/equatable.dart';

/// Profile stats model
class ProfileStatsModel extends Equatable {
  /// Default constructor
  const ProfileStatsModel({
    required this.avoidedCO2eEmission,
    required this.savedMoney,
    required this.orderCount,
    required this.points,
    required this.plantedTrees,
  });

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

  /// To json
  Map<String, dynamic> toJson() {
    return {
      'avoidedCO2eEmission': avoidedCO2eEmission,
      'savedMoney': savedMoney,
      'orderCount': orderCount,
      'points': points,
      'plantedTrees': plantedTrees,
    };
  }

  /// From json
  factory ProfileStatsModel.fromJson(Map<String, dynamic> json) {
    return ProfileStatsModel(
      avoidedCO2eEmission: json['avoidedCO2eEmission'] as double?,
      savedMoney: json['savedMoney'] as double?,
      orderCount: json['orderCount'] as double?,
      points: json['points'] as double?,
      plantedTrees: json['plantedTrees'] as double?,
    );
  }

  @override
  List<Object?> get props => [
        avoidedCO2eEmission,
        savedMoney,
        orderCount,
        points,
        plantedTrees,
      ];
}
