import 'package:equatable/equatable.dart';

/// Shop model
class ShopModel extends Equatable {
  /// Constructor
  const ShopModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isLiked,
    required this.description,
    required this.localization,
    required this.startDate,
    required this.endDate,
  });

  /// Shop ID
  final String id;

  /// Shop name
  final String name;

  /// Shop description
  final String description;

  /// Shop localization
  final String localization;

  /// Image URL
  final String imageUrl;

  /// Is liked
  final bool isLiked;

  /// Start date
  final String startDate;

  /// End date
  final String endDate;

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'isLiked': isLiked,
      'description': description,
      'localization': localization,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  /// from json
  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      isLiked: json['isLiked'] as bool,
      description: json['description'] as String,
      localization: json['localization'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        isLiked,
        description,
        localization,
        startDate,
        endDate,
      ];
}
