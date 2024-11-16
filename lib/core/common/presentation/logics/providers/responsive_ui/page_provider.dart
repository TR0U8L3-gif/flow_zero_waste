import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_listener.dart';
import 'package:flow_zero_waste/core/enums/nav_bar_type_enum.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Default compact percentage.
const compactPercentageDefault = 0.64;

/// Default medium percentage.
const mediumPercentageDefault = 0.56;

/// Default expanded percentage.
const expandedPercentageDefault = 0.72;

/// class to manage page used in Responsive UI
@singleton
class PageProvider extends ChangeNotifier implements PageListener {
  Size _pageSize = pageSizeDefault;
  int _numberOfContainers = numberOfContainersDefault;
  PageLayoutSize _layoutSize = layoutSizeDefault;
  double _compactPercentage = compactPercentageDefault;
  double _mediumPercentage = mediumPercentageDefault;
  double _expandedPercentage = expandedPercentageDefault;
  NavBarType _navBarType = NavBarType.bottom;

  @override
  Size get size => _pageSize;
  @override
  int get numberOfContainers => _numberOfContainers;
  @override
  double get spacing => calculateSpacing(_layoutSize);
  @override
  PageLayoutSize get layoutSize => _layoutSize;

  double get spacingQuarter => calculateSpacing(_layoutSize) / 4;
  double get spacingHalf => calculateSpacing(_layoutSize) / 2;
  double get spacingDouble => calculateSpacing(_layoutSize) * 2;

  @override
  bool get isSecondaryContainerAccessible =>
      calculateSecondaryContainerAccessibility(numberOfContainers);
  @override
  bool get isTertiaryContainerAccessible =>
      calculateTertiaryContainerAccessibility(_numberOfContainers);

  /// Determines how to divide compact layout based on percentage.
  double get compactPercentage => _compactPercentage;

  /// Determines how to divide medium layout based on percentage.
  double get mediumPercentage => _mediumPercentage;

  /// Determines how to divide expanded layout based on percentage.
  double get expandedPercentage => _expandedPercentage;

  /// Getter for the navigation bar type.
  NavBarType get navBarType => _navBarType;

  @override
  bool calculateSecondaryContainerAccessibility(int number) {
    return number >= 2;
  }

  @override
  bool calculateTertiaryContainerAccessibility(int number) {
    return number >= 3;
  }

  /// Update the page size and notify listeners
  @override
  void updatePageSize(Size size) {
    if (size == _pageSize) {
      return;
    }

    _pageSize = size;

    final result = numberOfContainersInLayout(size);

    _numberOfContainers = result.containers;
    _layoutSize = result.layout;

    final newNavBarType = _calculateNavBarType(_layoutSize, size);
    if (_navBarType != newNavBarType) {
      _navBarType = newNavBarType;
    }

    notifyListeners();
  }

  /// Calculate the spacing based on the layout size
  @override
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

  /// Returns the number of containers and layout size based on the current size
  @override
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

  /// Method to set page layout size percentage 
  void updatePagePercentage({
    double? compactPercentage,
    double? mediumPercentage,
    double? expandedPercentage,
  }) {
    var isChanged = false;
    if (compactPercentage != null) {
      _compactPercentage = compactPercentage;
      isChanged = true;
    }
    if (mediumPercentage != null) {
      _mediumPercentage = mediumPercentage;
      isChanged = true;
    }
    if (expandedPercentage != null) {
      _expandedPercentage = expandedPercentage;
      isChanged = true;
    }
    if (isChanged) {
      notifyListeners();
    }
  }

    /// Method to calculate the navigation bar type.
  NavBarType _calculateNavBarType(PageLayoutSize layoutSize, Size size) {
    if (layoutSize.isCompact) {
      if (size.isCompactPercentage(_compactPercentage)) {
        return NavBarType.bottom;
      } else {
        return NavBarType.bottomSemiExtended;
      }
    } else if (layoutSize.isMedium) {
      if (size.isMediumPercentage(_mediumPercentage)) {
        return NavBarType.bottomSemiExtended;
      } else {
        return NavBarType.bottomExtended;
      }
    } else if (layoutSize.isExpanded) {
      if (size.isExpandedPercentage(_expandedPercentage)) {
        return NavBarType.rail;
      } else {
        return NavBarType.railExtended;
      }
    } else {
      return NavBarType.railExtended;
    }
  }
}
