import 'package:equatable/equatable.dart';

/// Model class that store the theme details data.
class ThemeDetailsModel extends Equatable {
  /// Constructor for [ThemeDetailsModel].
  const ThemeDetailsModel({required this.brightness, required this.contrast});

  /// Determines the brightness of the theme.
  final String brightness;

  /// Determines the contrast of the theme.
  final String contrast;

  /// Converts the JSON object to a [ThemeDetailsModel].
  factory ThemeDetailsModel.fromJson(Map<String, dynamic> json) {
    return ThemeDetailsModel(
      brightness: json['brightness'] as String,
      contrast: json['contrast'] as String,
    );
  }

  /// Converts the [ThemeDetailsModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'brightness': brightness,
      'contrast': contrast,
    };
  }

  @override
  List<Object?> get props => [brightness, contrast];
}
