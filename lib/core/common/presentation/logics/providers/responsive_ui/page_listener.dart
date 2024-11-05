import 'dart:ui';

import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';

/// default value for page size
const pageSizeDefault = Size.zero;

/// default value for number of containers
const numberOfContainersDefault = 1;

/// default value for layout size
const layoutSizeDefault = PageLayoutSize.compact;

/// default value for spacing
const spacingDefault = AppSize.spacingCompact;

/// abstract class to manage page used in Responsive UI
abstract class PageListener {
  /// getter for page size
  Size get size;

  /// getter for number of containers
  int get numberOfContainers;

  /// getter for spacing
  double get spacing;

  /// getter for layout size
  PageLayoutSize get layoutSize;

  /// getter for primary container accessibility
  bool get isSecondaryContainerAccessible;

  /// getter for secondary container accessibility
  bool get isTertiaryContainerAccessible;

  /// method to update page size
  void updatePageSize(Size size);

  /// method to update page spacing
  double calculateSpacing(PageLayoutSize layout);

  /// method to update number of containers
  bool calculateSecondaryContainerAccessibility(int number);

  /// method to update layout size
  bool calculateTertiaryContainerAccessibility(int number);

  /// method to calculate number of containers in layout
  ({int containers, PageLayoutSize layout}) numberOfContainersInLayout(
    Size? size,
  );
}
