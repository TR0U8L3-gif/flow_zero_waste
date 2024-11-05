import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/enums/nav_bar_type_enum.dart';
import 'package:flow_zero_waste/core/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _iconSizeDefault = 24.0;
const _iconContainerSize = 80.0;

/// A navigation page widget.
/// This widget is used to display a page with
/// bottom navigation bar or  navigation rail.
class NavigationPage extends StatefulWidget {
  /// Creates a navigation page widget.
  const NavigationPage({
    required this.navItems,
    required this.selectedIndex,
    required this.onSelectedIndex,
    this.compactPercentage = 0.64,
    this.mediumPercentage = 0.56,
    this.expandedPercentage = 0.72,
    this.textScaler,
    super.key,
    this.child,
  });

  /// The list of navigation items.
  final List<NavItem> navItems;

  /// The selected index of the navigation items.
  final int selectedIndex;

  /// The function to call when the index is selected.
  final void Function(int) onSelectedIndex;

  /// The child widget.
  final Widget? child;

  /// Determines how to divide compact layout based on percentage.
  final double? compactPercentage;

  /// Determines how to divide medium layout based on percentage.
  final double? mediumPercentage;

  /// Determines how to divide expanded layout based on percentage.
  final double? expandedPercentage;

  /// The text scaler.
  final TextScaler? textScaler;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  String? biggestItemTitle;
  bool isNavRailExpanded = true;

  @override
  void initState() {
    biggestItemTitle = _findBiggestItem(widget.navItems);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final page = context.watch<PageProvider>();
    final labelStyle = _calculateLabelStyle(page.navBarType, theme.textTheme);
    final bottomNavBarHeight =
        theme.navigationBarTheme.height ?? AppSize.xxxl72;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: Builder(
          builder: (context) {
            if (page.navBarType.isBottom) {
              return Column(
                children: [
                  Expanded(
                    child: Semantics(
                      sortKey: const OrdinalSortKey(1),
                      child: widget.child ?? const SizedBox.shrink(),
                    ),
                  ),
                  Semantics(
                    sortKey: const OrdinalSortKey(0),
                    child: SizedBox(
                      height: bottomNavBarHeight,
                      width: page.size.width,
                      child: UnconstrainedBox(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: page.size.width,
                          child: NavigationBar(
                            backgroundColor: Colors.transparent,
                            height: bottomNavBarHeight,
                            selectedIndex: widget.selectedIndex,
                            onDestinationSelected: widget.onSelectedIndex,
                            destinations: widget.navItems
                                .map(
                                  (navItem) => Theme(
                                    data: theme.copyWith(
                                      navigationBarTheme:
                                          theme.navigationBarTheme.copyWith(
                                        labelTextStyle: WidgetStateProperty.all(
                                          labelStyle,
                                        ),
                                      ),
                                    ),
                                    child: NavigationDestination(
                                      icon: Icon(
                                        navItem.icon,
                                      ),
                                      label: navItem.title,
                                      tooltip: navItem.tooltip,
                                    ),
                                  ),
                                )
                                .toList(),
                            indicatorShape: page.navBarType == NavBarType.bottom
                                ? const CircleBorder(eccentricity: 0.24)
                                : null,
                            labelBehavior: page.navBarType == NavBarType.bottom
                                ? NavigationDestinationLabelBehavior.alwaysHide
                                : (page.navBarType ==
                                        NavBarType.bottomSemiExtended
                                    ? NavigationDestinationLabelBehavior
                                        .onlyShowSelected
                                    : NavigationDestinationLabelBehavior
                                        .alwaysShow),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            final minExtendedWidth = _calculateWidthFromTitle(
              title: biggestItemTitle,
              labelStyle: labelStyle,
              textScaler: widget.textScaler,
              iconSize: _iconSizeDefault,
              isExpanded: true,
            );
            final closedRailLabelStyle =
                _calculateLabelStyle(NavBarType.rail, theme.textTheme);
            return Row(
              children: [
                AnimatedContainer(
                  duration:
                      const Duration(milliseconds: AppSize.durationExtraSmall),
                  width: isNavRailExpanded &&
                          page.navBarType == NavBarType.railExtended
                      ? minExtendedWidth
                      : _calculateWidthFromTitle(
                          title: biggestItemTitle,
                          textScaler: widget.textScaler,
                          labelStyle: closedRailLabelStyle,
                          iconSize: _iconSizeDefault,
                          isExpanded: false,
                        ),
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: NavigationRail(
                    extended: isNavRailExpanded &&
                        page.navBarType == NavBarType.railExtended,
                    backgroundColor: Colors.transparent,
                    selectedIndex: widget.selectedIndex,
                    onDestinationSelected: widget.onSelectedIndex,
                    minExtendedWidth: minExtendedWidth,
                    destinations: widget.navItems
                        .map(
                          (navItem) => NavigationRailDestination(
                            icon: Icon(navItem.icon, size: _iconSizeDefault),
                            label: Text(
                              navItem.title,
                              style: isNavRailExpanded &&
                                      page.navBarType == NavBarType.railExtended
                                  ? labelStyle
                                  : closedRailLabelStyle,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                          ),
                        )
                        .toList(),
                    labelType: isNavRailExpanded &&
                            page.navBarType == NavBarType.railExtended
                        ? null
                        : NavigationRailLabelType.selected,
                    leading: SizedBox(
                      width: 0,
                      height: (page.spacing / 3).roundToDouble(),
                    ),
                    trailing: page.navBarType == NavBarType.railExtended
                        ? Expanded(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: page.spacing + AppSize.s6,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    isNavRailExpanded
                                        ? Icons.menu_open_rounded
                                        : Icons.menu_rounded,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isNavRailExpanded = !isNavRailExpanded;
                                    });
                                  },
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
                Expanded(
                  child: widget.child ?? const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
      extendBody: true,
    );
  }

  String _findBiggestItem(List<NavItem> navItems) {
    if (navItems.isEmpty) {
      return navItems.first.title;
    }
    var title = navItems.first.title;

    for (var i = 1; i < navItems.length; i++) {
      if (title.length < navItems[i].title.length) {
        title = navItems[i].title;
      }
    }

    return title;
  }

  TextStyle? _calculateLabelStyle(NavBarType navBarType, TextTheme theme) {
    if (navBarType.isBottom) {
      if (navBarType == NavBarType.bottomExtended) {
        return theme.labelMedium;
      }
      return theme.labelSmall;
    } else {
      if (navBarType == NavBarType.rail) {
        return theme.labelMedium;
      }
      return theme.labelLarge;
    }
  }

  double? _calculateWidthFromTitle({
    required double iconSize,
    required bool isExpanded,
    String? title,
    TextStyle? labelStyle,
    TextScaler? textScaler,
  }) {
    if (title == null || labelStyle == null) {
      return null;
    }

    final width = Text(
      title,
      style: labelStyle,
    )
        .calculateSize(
          maxLines: 1,
          textScaler: textScaler,
        )
        .width;
    final result = width + iconSize + (isExpanded ? _iconContainerSize : 0);
    return result.roundToDouble();
  }
}

/// A navigation item class.
class NavItem {
  /// Creates a navigation item.
  const NavItem({
    required this.icon,
    required this.title,
    required this.tooltip,
  });

  /// The icon of the navigation item.
  final IconData icon;

  /// The title of the navigation item.
  final String title;

  /// The tooltip of the navigation item.
  final String? tooltip;
}
