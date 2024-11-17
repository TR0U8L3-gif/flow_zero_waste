import 'dart:math';

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
    this.opacity = 0.4,
    super.key,
  });

  /// Height
  final double? height;

  /// Width
  final double? width;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Background color
  final Color? backgroundColor;

  /// Shimmer color
  final Color? shimmerColor;

  /// Opacity
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final shimmerColorDark = _shimmerColor(600);
    final shimmerColorLight = _shimmerColor(300);
    return Opacity(
      opacity: opacity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(AppSize.s),
        child: Shimmer.fromColors(
          baseColor: backgroundColor ??
              Colors.grey[isDark ? 700 : 400] ??
              (isDark ? Colors.black : Colors.white),
          highlightColor: shimmerColor ??
              Colors.grey[isDark ? shimmerColorDark : shimmerColorLight] ??
              Colors.grey,
          child: Container(
            height: height ?? double.infinity,
            width: width ?? double.infinity,
            color: backgroundColor ??
                Colors.grey[isDark ? 700 : 400] ??
                (isDark ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }

  int _shimmerColor(int value) {
    final result = (value / 100 * (opacity * 2.4)).toInt() * 100;
    if (result > 900) {
      return 900;
    }
    if (result < 100) {
      return 100;
    }
    return result;
  }
}
