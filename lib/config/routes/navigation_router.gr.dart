// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flow_zero_waste/src/app/presentation/pages/app_naviagtion_page.dart'
    as _i1;
import 'package:flow_zero_waste/src/bogus/main_page.dart' as _i5;
import 'package:flow_zero_waste/src/bogus/material_builder_page.dart' as _i6;
import 'package:flow_zero_waste/src/bogus/semi_main.dart' as _i7;
import 'package:flow_zero_waste/src/browse/presentation/pages/browse_page.dart'
    as _i2;
import 'package:flow_zero_waste/src/discover/presentation/pages/discover_page.dart'
    as _i3;
import 'package:flow_zero_waste/src/favorites/presentation/pages/favorites_page.dart'
    as _i4;
import 'package:flow_zero_waste/src/onboarding/presentation/pages/onboarding_page.dart'
    as _i8;
import 'package:flow_zero_waste/src/orders/presentation/pages/orders_page.dart'
    as _i9;
import 'package:flow_zero_waste/src/profile/presentation/pages/profile_page.dart'
    as _i10;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.AppNavigationPage]
class AppNavigationRoute extends _i11.PageRouteInfo<void> {
  const AppNavigationRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AppNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppNavigationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppNavigationPage();
    },
  );
}

/// generated route for
/// [_i2.BrowsePage]
class BrowseRoute extends _i11.PageRouteInfo<void> {
  const BrowseRoute({List<_i11.PageRouteInfo>? children})
      : super(
          BrowseRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrowseRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i2.BrowsePage();
    },
  );
}

/// generated route for
/// [_i3.DiscoverPage]
class DiscoverRoute extends _i11.PageRouteInfo<void> {
  const DiscoverRoute({List<_i11.PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i3.DiscoverPage();
    },
  );
}

/// generated route for
/// [_i4.FavoritesPage]
class FavoritesRoute extends _i11.PageRouteInfo<void> {
  const FavoritesRoute({List<_i11.PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i4.FavoritesPage();
    },
  );
}

/// generated route for
/// [_i5.MainPage]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainPage();
    },
  );
}

/// generated route for
/// [_i6.MaterialBuilderPage]
class MaterialBuilderRoute extends _i11.PageRouteInfo<void> {
  const MaterialBuilderRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MaterialBuilderRoute.name,
          initialChildren: children,
        );

  static const String name = 'MaterialBuilderRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.MaterialBuilderPage();
    },
  );
}

/// generated route for
/// [_i7.MyHomePage]
class MyHomeRoute extends _i11.PageRouteInfo<void> {
  const MyHomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.MyHomePage();
    },
  );
}

/// generated route for
/// [_i8.OnboardingPage]
class OnboardingRoute extends _i11.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    required void Function({bool? success}) onResult,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          OnboardingRoute.name,
          args: OnboardingRouteArgs(
            onResult: onResult,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>();
      return _i8.OnboardingPage(
        onResult: args.onResult,
        key: args.key,
      );
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({
    required this.onResult,
    this.key,
  });

  final void Function({bool? success}) onResult;

  final _i12.Key? key;

  @override
  String toString() {
    return 'OnboardingRouteArgs{onResult: $onResult, key: $key}';
  }
}

/// generated route for
/// [_i9.OrdersPage]
class OrdersRoute extends _i11.PageRouteInfo<void> {
  const OrdersRoute({List<_i11.PageRouteInfo>? children})
      : super(
          OrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i9.OrdersPage();
    },
  );
}

/// generated route for
/// [_i10.ProfilePage]
class ProfileRoute extends _i11.PageRouteInfo<void> {
  const ProfileRoute({List<_i11.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i10.ProfilePage();
    },
  );
}
