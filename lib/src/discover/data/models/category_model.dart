import 'package:equatable/equatable.dart';

/// Category model
class CategoryModel extends Equatable {
  /// Constructor
  const CategoryModel({
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

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  /// from json
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
      ];
}
