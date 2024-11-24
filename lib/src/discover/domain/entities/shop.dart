import 'package:equatable/equatable.dart';

/// Shop entity
class Shop extends Equatable {
  /// Constructor
  const Shop({
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
  final DateTime startDate;

  /// End date
  final DateTime endDate;

  /// CopyWith method
  Shop copyWith({
    String? id,
    String? name,
    String? imageUrl,
    bool? isLiked,
    String? description,
    String? localization,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isLiked: isLiked ?? this.isLiked,
      description: description ?? this.description,
      localization: localization ?? this.localization,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
