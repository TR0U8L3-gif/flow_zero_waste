import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flutter/material.dart';

/// A class that store the theme data.
class ThemeDetails extends Equatable {
  /// Constructor for [ThemeDetails].
  const ThemeDetails({
    required this.brightness,
    required this.contrast,
  });

  /// Brightness enum.
  final Brightness brightness;

  /// Contrast enum.
  final Contrast contrast;

  @override
  List<Object?> get props => [brightness, contrast];

  /// Copy existing [ThemeDetails] with new values.
  ThemeDetails copyWith({
    Brightness? brightness,
    Contrast? contrast,
  }) {
    return ThemeDetails(
      brightness: brightness ?? this.brightness,
      contrast: contrast ?? this.contrast,
    );
  }
}
