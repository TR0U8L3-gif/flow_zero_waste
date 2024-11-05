
import 'package:flow_zero_waste/config/assets/color/app_colors.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flutter/material.dart';

/// Class to define the color scheme of the app
class AppColorScheme {
  AppColorScheme._();

  /// Color scheme
  static ColorScheme getColorScheme(Contrast mode, Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: AppColors.primary(mode, brightness),
      surfaceTint: AppColors.surfaceTint(mode, brightness),
      onPrimary: AppColors.onPrimary(mode, brightness),
      primaryContainer: AppColors.primaryContainer(mode, brightness),
      onPrimaryContainer: AppColors.onPrimaryContainer(mode, brightness),
      secondary: AppColors.secondary(mode, brightness),
      onSecondary: AppColors.onSecondary(mode, brightness),
      secondaryContainer: AppColors.secondaryContainer(mode, brightness),
      onSecondaryContainer: AppColors.onSecondaryContainer(mode, brightness),
      tertiary: AppColors.tertiary(mode, brightness),
      onTertiary: AppColors.onTertiary(mode, brightness),
      tertiaryContainer: AppColors.tertiaryContainer(mode, brightness),
      onTertiaryContainer: AppColors.onTertiaryContainer(mode, brightness),
      error: AppColors.error(mode, brightness),
      onError: AppColors.onError(mode, brightness),
      errorContainer: AppColors.errorContainer(mode, brightness),
      onErrorContainer: AppColors.onErrorContainer(mode, brightness),
      surface: AppColors.surface(mode, brightness),
      onSurface: AppColors.onSurface(mode, brightness),
      onSurfaceVariant: AppColors.onSurfaceVariant(mode, brightness),
      outline: AppColors.outline(mode, brightness),
      outlineVariant: AppColors.outlineVariant(mode, brightness),
      shadow: AppColors.shadow(mode, brightness),
      scrim: AppColors.scrim(mode, brightness),
      inverseSurface: AppColors.inverseSurface(mode, brightness),
      inversePrimary: AppColors.inversePrimary(mode, brightness),
      primaryFixed: AppColors.primaryFixed(mode, brightness),
      onPrimaryFixed: AppColors.onPrimaryFixed(mode, brightness),
      primaryFixedDim: AppColors.primaryFixedDim(mode, brightness),
      onPrimaryFixedVariant: AppColors.onPrimaryFixedVariant(mode, brightness),
      secondaryFixed: AppColors.secondaryFixed(mode, brightness),
      onSecondaryFixed: AppColors.onSecondaryFixed(mode, brightness),
      secondaryFixedDim: AppColors.secondaryFixedDim(mode, brightness),
      onSecondaryFixedVariant:
          AppColors.onSecondaryFixedVariant(mode, brightness),
      tertiaryFixed: AppColors.tertiaryFixed(mode, brightness),
      onTertiaryFixed: AppColors.onTertiaryFixed(mode, brightness),
      tertiaryFixedDim: AppColors.tertiaryFixedDim(mode, brightness),
      onTertiaryFixedVariant:
          AppColors.onTertiaryFixedVariant(mode, brightness),
      surfaceDim: AppColors.surfaceDim(mode, brightness),
      surfaceBright: AppColors.surfaceBright(mode, brightness),
      surfaceContainerLowest:
          AppColors.surfaceContainerLowest(mode, brightness),
      surfaceContainerLow: AppColors.surfaceContainerLow(mode, brightness),
      surfaceContainer: AppColors.surfaceContainer(mode, brightness),
      surfaceContainerHigh: AppColors.surfaceContainerHigh(mode, brightness),
      surfaceContainerHighest:
          AppColors.surfaceContainerHighest(mode, brightness),
    );
  }
}
