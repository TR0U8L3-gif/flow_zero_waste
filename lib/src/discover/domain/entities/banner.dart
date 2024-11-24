import 'package:equatable/equatable.dart';

/// Banner entity
class Banner extends Equatable {
  /// Default constructor
  const Banner({
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

  /// CopyWith method
  Banner copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? description,
  }) {
    return Banner(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
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
