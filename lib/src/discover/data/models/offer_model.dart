import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';

/// offer model
class OfferModel {
  /// Constructor
  OfferModel({
    required this.id,
    required this.rating,
    required this.distance,
    required this.newOffers,
    required this.shop,
  });

  /// Offer ID
  final String id;

  /// Rating
  final double rating;

  /// Distance
  final double distance;

  /// New offers
  final double newOffers;

  /// Shop
  final ShopModel shop;

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'distance': distance,
      'newOffers': newOffers,
      'shop': shop.toJson(),
    };
  }

  /// from json
  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as String,
      rating: json['rating'] as double,
      distance: json['distance'] as double,
      newOffers: json['newOffers'] as double,
      shop: ShopModel.fromJson(json['shop'] as Map<String, dynamic>),
    );
  }
}
