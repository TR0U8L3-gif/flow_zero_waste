
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flutter/material.dart';

/// extension on [Size] to check the layout size
extension PageSizeExtension on Size {
  /// check if the layout is extra large
  bool get isExtraLarge =>
      width >= AppSize.layoutExtraLarge.min &&
      width <= AppSize.layoutExtraLarge.max;
  /// check if the layout is large
  bool get isLarge =>
      width >= AppSize.layoutLarge.min && width <= AppSize.layoutLarge.max;
  /// check if the layout is expanded from 
  /// `min` to `min + (max - min) * percentage` 
  bool isExpandedPercentage(double percentage) =>
      width >= AppSize.layoutExpanded.min &&
      width <=
          AppSize.layoutExpanded.min +
              (AppSize.layoutExpanded.max - AppSize.layoutExpanded.min) *
                  percentage;
  /// check if the layout is expanded
  bool get isExpanded =>
      width >= AppSize.layoutExpanded.min &&
      width <= AppSize.layoutExpanded.max;
  /// check if the layout is medium from 
  /// `min` to `min + (max - min) * percentage` 
  bool isMediumPercentage(double percentage) =>
      width >= AppSize.layoutMedium.min &&
      width <=
          AppSize.layoutMedium.min +
              (AppSize.layoutMedium.max - AppSize.layoutMedium.min) *
                  percentage;
  /// check if the layout is medium
  bool get isMedium =>
      width >= AppSize.layoutMedium.min && width <= AppSize.layoutMedium.max;
  /// check if the layout is compact from
  /// `min` to `min * percentage` because min is 0
  bool isCompactPercentage(double percentage) =>
      width >= AppSize.layoutCompact.min &&
      width <= AppSize.layoutCompact.max * percentage;
  /// check if the layout is compact
  bool get isCompact =>
      width >= AppSize.layoutCompact.min && width <= AppSize.layoutCompact.max;
}
