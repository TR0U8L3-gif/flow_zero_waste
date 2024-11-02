import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/page_listener.dart';
import 'package:flow_zero_waste/core/enums/container_enum.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flutter/material.dart';

const _containerWidthDefault = AppSize.paneCompact;
const _containerWidthMinDefault = AppSize.xxl;

const _containerDeadZone = AppSize.m;
const _containerWidthMinRatio = 0.64;
const _containerWidthMinimalizeRatio = 0.44;
const _minimaximizeThreshold = 0.8;

/// Class to manage scaffold page used in Responsive UI
class ScaffoldPageProvider extends ChangeNotifier implements PageListener {
  // ignore: unused_field
  bool _paddingTop = false;
  // ignore: unused_field
  bool _paddingBottom = false;
  bool _paddingLeft = false;
  bool _paddingRight = false;

  Size _pageSize = pageSizeDefault;
  int _numberOfContainers = numberOfContainersDefault;
  PageLayoutSize _layoutSize = layoutSizeDefault;
  bool _secondaryContainerVisible = false;
  bool _tertiaryContainerVisible = false;
  double _secondaryContainerWidth = _containerWidthDefault;
  double _tertiaryContainerWidth = _containerWidthDefault;
  ContainerResize _containerResize = ContainerResize.none;
  double _containerWidthMin = _containerWidthMinDefault.roundToDouble();
  double _minimizing = 0;
  double _maximizing = 0;
  // ignore: unused_field
  double _dragWidth = 0;
  double _dragHeight = 0;
  double? _providedSpacing;

  @override
  Size get size => _pageSize;
  @override
  int get numberOfContainers => _numberOfContainers;

  @override
  double get spacing => calculateSpacing(_layoutSize);

  @override
  PageLayoutSize get layoutSize => _layoutSize;

  /// Check if the secondary container is resizing
  bool get isSecondaryResizing => _containerResize == ContainerResize.secondary;

  /// Check if the tertiary container is resizing
  bool get isTertiaryResizing => _containerResize == ContainerResize.tertiary;

  /// Check if the container is resizing
  bool get isResizing => _containerResize != ContainerResize.none;

  /// Check if the secondary container is minimizing and
  /// get value from 0 to 1 based on the drag action
  double get minimizing => _minimizing;

  /// Check if the secondary container is maximizing and
  /// get value from 0 to 1 based on the drag action
  double get maximizing => _maximizing;

  /// Check if the secondary container is visible
  bool get isSecondaryContainerVisible => _secondaryContainerVisible;

  /// Check if the tertiary container is visible
  bool get isTertiaryContainerVisible => _tertiaryContainerVisible;

  /// Check if the secondary container is minimalize
  bool get isSecondaryContainerMinimalize =>
      _secondaryContainerWidth <= _containerWidthMin;

  /// Check if the tertiary container is minimalize
  bool get isTertiaryContainerMinimalize =>
      _tertiaryContainerWidth <= _containerWidthMin;

  /// get the secondary container width
  double get secondaryContainerWidth =>
      _calculateContainerDisplayedWidth(_secondaryContainerWidth);

  /// get the tertiary container width
  double get tertiaryContainerWidth =>
      _calculateContainerDisplayedWidth(_tertiaryContainerWidth);

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

  /// Update the page padding and notify listeners
  void initialize({
    bool? paddingTop,
    bool? paddingBottom,
    bool? paddingLeft,
    bool? paddingRight,
    bool? secondaryContainerVisible,
    bool? tertiaryContainerVisible,
    double? containerMinWidth,
    double? providedSpacing,
  }) {
    if (paddingTop != null) _paddingTop = paddingTop;
    if (paddingBottom != null) _paddingBottom = paddingBottom;
    if (paddingLeft != null) _paddingLeft = paddingLeft;
    if (paddingRight != null) _paddingRight = paddingRight;
    if (secondaryContainerVisible != null) {
      _secondaryContainerVisible = secondaryContainerVisible;
    }
    if (tertiaryContainerVisible != null) {
      _tertiaryContainerVisible = tertiaryContainerVisible;
    }
    if (containerMinWidth != null) {
      _containerWidthMin = containerMinWidth.roundToDouble();
    }
    _providedSpacing = providedSpacing;
    notifyListeners();
  }

  /// Update the page size and notify listeners
  @override
  void updatePageSize(Size size) {
    if (size == _pageSize) {
      return;
    }

    if (_secondaryContainerVisible && isSecondaryContainerAccessible) {
      _secondaryContainerWidth =
          _calculateContainerPercentagePageWidth(true, size.width);
    }
    if (_tertiaryContainerVisible && isTertiaryContainerAccessible) {
      _tertiaryContainerWidth =
          _calculateContainerPercentagePageWidth(false, size.width);
    }

    _pageSize = size;
    final result = numberOfContainersInLayout(size);

    if (_numberOfContainers != result.containers) {
      final secondaryAccessible =
          calculateSecondaryContainerAccessibility(result.containers);
      final tertiaryAccessible =
          calculateTertiaryContainerAccessibility(result.containers);
      if (secondaryAccessible && !isSecondaryContainerAccessible) {
        _secondaryContainerWidth =
            _calculateContainerDefaultSize(result.layout);
      }
      if (tertiaryAccessible) {
        _tertiaryContainerWidth = _calculateContainerDefaultSize(result.layout);
        _secondaryContainerWidth = _calculateContainerLeftWidth(
          _secondaryContainerWidth,
          _tertiaryContainerWidth,
        );
      } else {
        _tertiaryContainerWidth = 0;
      }
    }

    _numberOfContainers = result.containers;
    _layoutSize = result.layout;

    _secondaryContainerWidth =
        _calculateContainerDisplayedWidth(_secondaryContainerWidth);
    _tertiaryContainerWidth =
        _calculateContainerDisplayedWidth(_tertiaryContainerWidth);

    notifyListeners();
  }

  /// Update the visibility of the secondary
  /// and tertiary containers and notify listeners
  void updateContainersVisibility({
    required bool isSecondary,
    required bool isVisible,
  }) {
    if (isSecondary) {
      _secondaryContainerWidth =
          isVisible ? _calculateContainerDefaultSize(_layoutSize) : 0;
      _secondaryContainerVisible = isVisible;
      if (_tertiaryContainerVisible && isTertiaryContainerAccessible) {
        _tertiaryContainerWidth = _calculateContainerLeftWidth(
          _tertiaryContainerWidth,
          _secondaryContainerWidth,
        );
      }
    } else {
      _tertiaryContainerWidth =
          isVisible ? _calculateContainerDefaultSize(_layoutSize) : 0;
      _tertiaryContainerVisible = isVisible;
      if (_secondaryContainerVisible && isSecondaryContainerAccessible) {
        _secondaryContainerWidth = _calculateContainerLeftWidth(
          _secondaryContainerWidth,
          _tertiaryContainerWidth,
        );
      }
    }

    _secondaryContainerWidth =
        _calculateContainerDisplayedWidth(_secondaryContainerWidth);
    _tertiaryContainerWidth =
        _calculateContainerDisplayedWidth(_tertiaryContainerWidth);

    notifyListeners();
  }

  /// Start resizing the container
  void resizeContainerStart(ContainerResize container) {
    _containerResize = container;
    _resetMiniMaximize();
    _resetDragValues();
    notifyListeners();
  }

  /// Update the container width based on the drag action
  void resizeContainerUpdate(double deltaX, double deltaY) {
    if (_containerResize == ContainerResize.none) return;

    final calculatedDeltaX =
        deltaX * (_containerResize == ContainerResize.secondary ? 1 : -1);
    final calculatedDeltaY = deltaY * -1;

    _dragWidth += calculatedDeltaX;
    _dragHeight += calculatedDeltaY;

    _minimizing = _calculateUpDownAction(_dragHeight, false);
    _maximizing = _calculateUpDownAction(_dragHeight, true);

    final threshold = _calculateUpDownThreshold();

    if (_dragWidth.abs() >= threshold ||
        (_dragWidth.abs() < threshold && _dragHeight.abs() < threshold)) {
      if (_containerResize == ContainerResize.secondary) {
        _secondaryContainerWidth = _calculateContainerWidth(
          calculatedDeltaX,
          _secondaryContainerWidth,
          true,
        );
      } else if (_containerResize == ContainerResize.tertiary) {
        _tertiaryContainerWidth = _calculateContainerWidth(
          calculatedDeltaX,
          _tertiaryContainerWidth,
          false,
        );
      }
    }

    notifyListeners();
  }

  /// Resize the container based on the drag action
  void resizeContainerEnd() {
    if (_containerResize == ContainerResize.secondary) {
      if (_maximizing >= _minimaximizeThreshold ||
          _minimizing >= _minimaximizeThreshold) {
        _secondaryContainerWidth = _calculateContainerWidthMinimaximize(
          _secondaryContainerWidth,
          isSecondaryResizing,
          _minimizing >= _minimaximizeThreshold,
          _maximizing >= _minimaximizeThreshold,
        );
        if (_tertiaryContainerVisible && isTertiaryContainerAccessible) {
          _tertiaryContainerWidth = _calculateContainerLeftWidth(
            _tertiaryContainerWidth,
            _secondaryContainerWidth,
          );
        }
      }
    } else if (_containerResize == ContainerResize.tertiary) {
      if (_maximizing >= _minimaximizeThreshold ||
          _minimizing >= _minimaximizeThreshold) {
        _tertiaryContainerWidth = _calculateContainerWidthMinimaximize(
          _tertiaryContainerWidth,
          !isTertiaryResizing,
          _minimizing >= _minimaximizeThreshold,
          _maximizing >= _minimaximizeThreshold,
        );
        if (_secondaryContainerVisible && isSecondaryContainerAccessible) {
          _secondaryContainerWidth = _calculateContainerLeftWidth(
            _secondaryContainerWidth,
            _tertiaryContainerWidth,
          );
        }
      }
    }
    _secondaryContainerWidth =
        _calculateContainerDisplayedWidth(_secondaryContainerWidth);
    _tertiaryContainerWidth =
        _calculateContainerDisplayedWidth(_tertiaryContainerWidth);

    _resetMiniMaximize();
    _resetDragValues();

    _containerResize = ContainerResize.none;

    notifyListeners();
  }

  /// Reset minimize and maximize values
  void _resetMiniMaximize() {
    _minimizing = 0;
    _maximizing = 0;
  }

  /// Calculate if the drag action is up or down
  double _calculateUpDownAction(double value, bool isUp) {
    final threshold = calculateSpacing(_layoutSize);
    final range = _calculateUpDownThreshold();
    final data = value * (isUp ? 1 : -1);
    double result;
    if (data < threshold) {
      result = 0;
    } else if (data < range) {
      result = (data - threshold) / (range - threshold);
    } else {
      result = 1;
    }
    return result;
  }

  /// Calculate the threshold for up and down action
  double _calculateUpDownThreshold() {
    return calculateSpacing(_layoutSize) * 2.8;
  }

  /// Reset drag values
  void _resetDragValues() {
    _dragHeight = 0;
    _dragWidth = 0;
  }

  @override

  /// Calculate the spacing based on the layout size
  double calculateSpacing(PageLayoutSize layout) {
    if (_providedSpacing != null) {
      return _providedSpacing!;
    }
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

  /// Calculate the width of container based on the layout size
  double _calculateContainerDefaultSize(PageLayoutSize layout) {
    switch (layout) {
      case PageLayoutSize.extraLarge:
        return AppSize.paneExtraLarge;
      case PageLayoutSize.large:
        return AppSize.paneLarge;
      case PageLayoutSize.expanded:
        return AppSize.paneExpanded;
      case PageLayoutSize.medium:
        return AppSize.paneMedium;
      case PageLayoutSize.compact:
        return AppSize.paneCompact;
      default:
        return _containerWidthDefault;
    }
  }

  /// Calculate the width of container on resize
  double _calculateContainerWidth(
    double delta,
    double width,
    bool isSecondary,
  ) {
    final calculatedWidth = width + delta;

    if (calculatedWidth <= _containerWidthMin) {
      return _containerWidthMin;
    }

    if (calculatedWidth <= width) {
      return calculatedWidth;
    }

    final secondaryVisibleAccessible =
        _secondaryContainerVisible && isSecondaryContainerAccessible;
    final tertiaryVisibleAccessible =
        _tertiaryContainerVisible && isTertiaryContainerAccessible;

    final secondaryWidth = secondaryVisibleAccessible
        ? (isSecondary ? calculatedWidth : _secondaryContainerWidth)
        : 0;
    final tertiaryWidth = tertiaryVisibleAccessible
        ? (isSecondary ? _tertiaryContainerWidth : calculatedWidth)
        : 0;
    final spacing = calculateSpacing(_layoutSize);
    final paddingWidth = (_paddingLeft ? spacing : 0) +
        (_paddingRight ? spacing : 0) +
        (secondaryVisibleAccessible ? spacing : 0) +
        (tertiaryVisibleAccessible ? spacing : 0);
    final mainWidth =
        _pageSize.width - secondaryWidth - tertiaryWidth - paddingWidth;
    final containerWidthDefault = _calculateContainerDefaultSize(_layoutSize);

    if (mainWidth < containerWidthDefault) {
      return width;
    }

    return calculatedWidth;
  }

  /// Calculate the max width of container
  double _calculateContainerMaxWidth(bool isSecondary) {
    // ignore: avoid_bool_literals_in_conditional_expressions
    final secondaryContainerVisible = isSecondary
        ? true
        : (_secondaryContainerVisible && isSecondaryContainerAccessible);
    // ignore: avoid_bool_literals_in_conditional_expressions
    final tertiaryContainerVisible = isSecondary
        ? (_tertiaryContainerVisible && isTertiaryContainerAccessible)
        : true;

    final spacing = calculateSpacing(_layoutSize);

    final otherContainer = isSecondary
        ? (tertiaryContainerVisible ? _tertiaryContainerWidth : 0)
        : (secondaryContainerVisible ? _secondaryContainerWidth : 0);

    final paddingWidth = (_paddingLeft ? spacing : 0) +
        (_paddingRight ? spacing : 0) +
        ((secondaryContainerVisible && isSecondaryContainerAccessible)
            ? spacing
            : 0) +
        ((tertiaryContainerVisible && isTertiaryContainerAccessible)
            ? spacing
            : 0);

    final containerDefaultValue = _calculateContainerDefaultSize(_layoutSize);

    return _pageSize.width -
        otherContainer -
        paddingWidth -
        containerDefaultValue;
  }

  double _calculateContainerLeftWidth(
    double currentWidth,
    double otherWidth, [
    bool maximize = false,
  ]) {
    final spacing = calculateSpacing(_layoutSize);
    final paddingWidth = (_paddingLeft ? spacing : 0) +
        (_paddingRight ? spacing : 0) +
        ((_secondaryContainerVisible && isSecondaryContainerAccessible)
            ? spacing
            : 0) +
        ((_tertiaryContainerVisible && isTertiaryContainerAccessible)
            ? spacing
            : 0);
    final containerDefaultValue = _calculateContainerDefaultSize(_layoutSize);
    final widthSum = otherWidth + paddingWidth + containerDefaultValue;

    if (currentWidth + widthSum > _pageSize.width || maximize) {
      return _pageSize.width - widthSum;
    } else {
      return currentWidth;
    }
  }

  /// Calculate the width of displayed container
  /// Snap container width to nearest breakpoint
  double _calculateContainerDisplayedWidth(double width) {
    final defaultContainerWidth = _calculateContainerDefaultSize(_layoutSize);
    if ((defaultContainerWidth - width).abs() <= _containerDeadZone) {
      return defaultContainerWidth.roundToDouble();
    }

    final minBreakPoint = defaultContainerWidth * _containerWidthMinRatio;
    final minimalizeBreakPoint = minBreakPoint * _containerWidthMinimalizeRatio;

    if (width < minimalizeBreakPoint) {
      return _containerWidthMin.roundToDouble();
    } else if (width < minBreakPoint) {
      return minBreakPoint.roundToDouble();
    }

    return width.roundToDouble();
  }

  /// Calculate the container width based on the percentage of the page width
  double _calculateContainerPercentagePageWidth(
    bool isSecondary,
    double newPageWidth,
  ) {
    final percentage =
        (isSecondary ? _secondaryContainerWidth : _tertiaryContainerWidth) /
            _pageSize.width;
    return newPageWidth * percentage;
  }

  /// Calculate the container width based minimization and maximization
  double _calculateContainerWidthMinimaximize(
    double width,
    bool isSecondary,
    bool isMinimize,
    bool isMaximize,
  ) {
    final defaultContainerWidth = _calculateContainerDefaultSize(_layoutSize);
    final maxWidth = _calculateContainerMaxWidth(isSecondary);

    final isMaxWidth = width >= (maxWidth - _containerDeadZone);

    if ((defaultContainerWidth - width).abs() <= _containerDeadZone) {
      if (isMinimize) {
        return _containerWidthMin;
      } else if (isMaximize) {
        if (isMaxWidth) {
          return _calculateContainerLeftWidth(
            width,
            defaultContainerWidth,
            true,
          );
        } else {
          return maxWidth;
        }
      }
    } else if (width < defaultContainerWidth) {
      if (isMaximize) {
        return defaultContainerWidth;
      } else if (isMinimize) {
        return _containerWidthMin;
      }
    } else if (width > defaultContainerWidth) {
      if (isMinimize) {
        return defaultContainerWidth;
      } else if (isMaximize) {
        if (isMaxWidth) {
          final otherWidth = isSecondary
              ? (isTertiaryContainerAccessible && _tertiaryContainerVisible)
                  ? _containerWidthMin
                  : 0.0
              : (isSecondaryContainerAccessible && _secondaryContainerVisible)
                  ? _containerWidthMin
                  : 0.0;
          return _calculateContainerLeftWidth(width, otherWidth, true);
        } else {
          return maxWidth;
        }
      }
    }

    return width;
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
