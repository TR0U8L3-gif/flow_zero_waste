import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer rectangle
class ShimmerRectangle extends StatelessWidget {
  /// Default constructor
  const ShimmerRectangle({
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.shimmerColor,
    this.opacity = 0.8,
    super.key,
  });

  /// Height
  final double? height;
  /// Width
  final double? width;
  /// Border radius
  final double? borderRadius;
  /// Background color
  final Color? backgroundColor;
  /// Shimmer color
  final Color? shimmerColor;
  /// Opacity
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;

    return Opacity(
      opacity: opacity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s),
        child: Shimmer.fromColors(
          baseColor: backgroundColor ?? Colors.grey[isDark ? 700 : 400]!,
          highlightColor: shimmerColor ??
              Colors.grey[isDark ? _shimmerColor(600) : _shimmerColor(300)]!,
          child: Container(
            height: height ?? double.infinity,
            width: width ?? double.infinity,
            color: backgroundColor ?? Colors.grey[isDark ? 700 : 400],
          ),
        ),
      ),
    );
  }

  int _shimmerColor(int value) => 
      (value / 100 * (opacity * 2.4)).toInt() * 100;
}
