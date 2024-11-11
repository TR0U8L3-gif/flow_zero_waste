import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/core/common/presentation/pages/responsive_ui/navigation_page.dart';
import 'package:flow_zero_waste/core/enums/app_navigation_item_enum.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flutter/material.dart';

/// App Navigation Page
@RoutePage()
class AppNavigationPage extends StatelessWidget {
  /// Default constructor
  const AppNavigationPage({super.key});


  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 0,
      routes: [
        for (final item in AppNavigationItem.values)
          _routesFromItem(item),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return NavigationPage(
          navItems: [
            for (final item in AppNavigationItem.values)
              NavItem(
                icon: _iconFromItem(context, item),
                title: _titleFromItem(context, item),
                tooltip: _tooltipFromItem(context, item),
              ),
          ],
          selectedIndex: tabsRouter.activeIndex,
          onSelectedIndex: tabsRouter.setActiveIndex,
          child: child,
        );
      },
    );
  }

  PageRouteInfo<dynamic> _routesFromItem(
    AppNavigationItem item,
  ) {
    switch (item) {
      case AppNavigationItem.discover:
        return const DiscoverRoute();
      case AppNavigationItem.browse:
        return const BrowseRoute();
      case AppNavigationItem.favorites:
        return const FavoritesRoute();
      case AppNavigationItem.orders:
        return const OrdersRoute();
      case AppNavigationItem.profile:
        return const ProfileRoute();
    }
  }

  /// method get title from item
  String _titleFromItem(
    BuildContext context,
    AppNavigationItem item,
  ) {
    switch (item) {
      case AppNavigationItem.discover:
        return context.l10n.discover;
      case AppNavigationItem.browse:
        return context.l10n.browse;
      case AppNavigationItem.favorites:
        return context.l10n.favorites;
      case AppNavigationItem.orders:
        return context.l10n.orders;
      case AppNavigationItem.profile:
        return context.l10n.profile;
    }
  }

  /// method get tooltip from item
  String _tooltipFromItem(
    BuildContext context,
    AppNavigationItem item,
  ) {
    switch (item) {
      case AppNavigationItem.discover:
        return context.l10n.discoverTooltip;
      case AppNavigationItem.browse:
        return context.l10n.browseTooltip;
      case AppNavigationItem.favorites:
        return context.l10n.favoritesTooltip;
      case AppNavigationItem.orders:
        return context.l10n.ordersTooltip;
      case AppNavigationItem.profile:
        return context.l10n.profileTooltip;
    }
  }

  /// method get icon from item
  IconData _iconFromItem(
    BuildContext context,
    AppNavigationItem item,
  ) {
    switch (item) {
      case AppNavigationItem.discover:
        return Icons.explore;
      case AppNavigationItem.browse:
        return Icons.category;
      case AppNavigationItem.favorites:
        return Icons.favorite;
      case AppNavigationItem.orders:
        return Icons.shopping_cart;
      case AppNavigationItem.profile:
        return Icons.person;
    }
  }
}
