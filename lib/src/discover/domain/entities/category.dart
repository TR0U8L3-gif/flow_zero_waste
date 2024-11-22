import 'package:equatable/equatable.dart';

/// Category entity
class Category extends Equatable {
  /// Constructor
  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  /// Category ID
  final String id;

  /// Category name
  final String name;

  /// Image URL
  final String imageUrl;

  /// CopyWith method
  Category copyWith({
    String? id,
    String? name,
    String? imageUrl,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
      ];
}
