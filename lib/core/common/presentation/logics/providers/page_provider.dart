import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/page_listener.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
/// class to manage page used in Responsive UI
class PageProvider extends ChangeNotifier implements PageListener {
  Size _pageSize = pageSizeDefault;
  int _numberOfContainers = numberOfContainersDefault;
  PageLayoutSize _layoutSize = layoutSizeDefault;

  @override
  Size get size => _pageSize;
  @override
  int get numberOfContainers => _numberOfContainers;
  @override
  double get spacing => calculateSpacing(_layoutSize);
  @override
  PageLayoutSize get layoutSize => _layoutSize;

  @override
  bool get isSecondaryContainerAccessible =>
      calculateSecondaryContainerAccessibility(numberOfContainers);
  @override
  bool get isTertiaryContainerAccessible =>
      calculateTertiaryContainerAccessibility(_numberOfContainers);

  @override
  bool calculateSecondaryContainerAccessibility(int number) {
    return number >= 2;
  }

  @override
  bool calculateTertiaryContainerAccessibility(int number) {
    return number >= 3;
  }

  @override

  /// Update the page size and notify listeners
  void updatePageSize(Size size) {
    if (size == _pageSize) {
      return;
    }

    _pageSize = size;

    final result = numberOfContainersInLayout(size);

    _numberOfContainers = result.containers;
    _layoutSize = result.layout;

    notifyListeners();
  }

  @override

  /// Calculate the spacing based on the layout size
  double calculateSpacing(PageLayoutSize layout) {
    switch (layout) {
      case PageLayoutSize.extraLarge:
        return AppSize.spacingExtraLarge;
      case PageLayoutSize.large:
        return AppSize.spacingLarge;
      case PageLayoutSize.expanded:
        return AppSize.spacingExpanded;
      case PageLayoutSize.medium:
        return AppSize.spacingMedium;
      case PageLayoutSize.compact:
        return AppSize.spacingCompact;
      default:
        return spacingDefault;
    }
  }

  @override

  /// Returns the number of containers and layout size based on the current size
  ({int containers, PageLayoutSize layout}) numberOfContainersInLayout(
    Size? size,
  ) {
    final currentSize = size ?? _pageSize;
    var containers = numberOfContainersDefault;
    var layout = layoutSizeDefault;

    for (var index = 0; index < AppSize.layoutList.length; index++) {
      final appSizeLayout = AppSize.layoutList[index];
      if (currentSize.width >= appSizeLayout.min &&
          currentSize.width <= appSizeLayout.max) {
        containers = () {
          if (index <= 1) {
            return 3;
          } else if (index == 2) {
            return 2;
          } else {
            return 1;
          }
        }();
        layout = () {
          switch (index) {
            case 0:
              return PageLayoutSize.extraLarge;
            case 1:
              return PageLayoutSize.large;
            case 2:
              return PageLayoutSize.expanded;
            case 3:
              return PageLayoutSize.medium;
            default:
              return PageLayoutSize.compact;
          }
        }();
        break;
      } else {
        continue;
      }
    }
    return (containers: containers, layout: layout);
  }
}
