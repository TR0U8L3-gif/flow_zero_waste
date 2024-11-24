import 'package:equatable/equatable.dart';

/// Banner model
class BannerModel extends Equatable {
  /// Default constructor
  const BannerModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  /// Banner id
  final String id;
  /// Banner image URL
  final String imageUrl;
  /// Banner title
  final String title;
  /// Banner description
  final String description;

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
    };
  }

  /// from json
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        title,
        description,
      ];
}
