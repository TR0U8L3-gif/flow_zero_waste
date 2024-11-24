import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';

/// Offer entity
class Offer extends Equatable {
  /// Default constructor
  const Offer({
    required this.id,
    required this.rating,
    required this.distance,
    required this.newOffers,
    required this.shop,
  });

  /// offer id
  final String id;

  /// Rating
  final double rating;

  /// Distance
  final double distance;

  /// new offers
  final double newOffers;

  /// shop
  final Shop shop;

  /// CopyWith method
  Offer copyWith({
    String? id,
    double? rating,
    double? distance,
    double? newOffers,
    Shop? shop,
  }) {
    return Offer(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      distance: distance ?? this.distance,
      newOffers: newOffers ?? this.newOffers,
      shop: shop ?? this.shop,
    );
  }

  @override
  List<Object?> get props => [
        id,
        rating,
        distance,
        newOffers,
        shop,
      ];
}
