// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Error builder
Widget errorBuilder(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
) =>
    const SizedBox.expand();

/// loading builder
Widget loadingBuilder(
  BuildContext context,
  Widget child,
  ImageChunkEvent? loadingProgress,
) {
  if (loadingProgress == null) {
    return child;
  }
  return SizedBox.expand(
    child: ShimmerRectangle(
      backgroundColor: context.colorScheme.primaryContainer,
    ),
  );
}

/// Frame builder
Widget frameBuilder(
  BuildContext context,
  Widget child,
  int? frame,
  bool wasSynchronouslyLoaded,
) {
  if (wasSynchronouslyLoaded) {
    return child;
  }
  return AnimatedOpacity(
    duration: const Duration(milliseconds: AppSize.durationSmall),
    opacity: frame == null ? 0 : 1,
    child: child,
  );
}
