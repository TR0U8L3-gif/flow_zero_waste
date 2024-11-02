import 'package:flow_zero_waste/core/enums/nav_bar_type_enum.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/size_extension.dart';
import 'package:flutter/material.dart';

/// A provider class to manage the navigation type of the app.
class NavigationTypeProvider extends ChangeNotifier {
  /// Constructor to initialize the navigation type provider.
  NavigationTypeProvider({
    required double compactPercentage,
    required double mediumPercentage,
    required double expandedPercentage,
  }) : 
    _compactPercentage = compactPercentage,
    _mediumPercentage = mediumPercentage,
    _expandedPercentage = expandedPercentage;

  /// Determines how to divide compact layout based on percentage.
  final double _compactPercentage;

  /// Determines how to divide medium layout based on percentage.
  final double _mediumPercentage;

  /// Determines how to divide expanded layout based on percentage.
  final double _expandedPercentage;

  /// Getter for the compact percentage.
  double get compactPercentage => _compactPercentage;

  /// Getter for the medium percentage.
  double get mediumPercentage => _mediumPercentage;

  /// Getter for the expanded percentage.
  double get expandedPercentage => _expandedPercentage;

  /// Navigation bar type.
  NavBarType _navBarType = NavBarType.bottom;

  /// Getter for the navigation bar type.
  NavBarType get navBarType => _navBarType;

  /// Method to set the navigation bar type.
  void setNavBarType(PageLayoutSize layoutSize, Size size) {
    final newNavBarType = calculateNavBarType(layoutSize, size);
    if (_navBarType != newNavBarType) {
      _navBarType = newNavBarType;
      notifyListeners();
    }
    notifyListeners();
  }

  /// Method to calculate the navigation bar type.
  NavBarType calculateNavBarType(PageLayoutSize layoutSize, Size size) {
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
