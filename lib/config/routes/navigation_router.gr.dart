// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flow_zero_waste/src/bogus/main_page.dart' as _i1;
import 'package:flow_zero_waste/src/bogus/semi_main.dart' as _i2;
import 'package:flow_zero_waste/src/onboarding/presentation/pages/onboarding_page.dart'
    as _i3;
import 'package:flutter/material.dart' as _i5;

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i4.PageRouteInfo<void> {
  const MainRoute({List<_i4.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.MainPage();
    },
  );
}

/// generated route for
/// [_i2.MyHomePage]
class MyHomeRoute extends _i4.PageRouteInfo<void> {
  const MyHomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.MyHomePage();
    },
  );
}

/// generated route for
/// [_i3.OnboardingPage]
class OnboardingRoute extends _i4.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    required void Function({bool? success}) onResult,
    _i5.Key? key,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          OnboardingRoute.name,
          args: OnboardingRouteArgs(
            onResult: onResult,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>();
      return _i3.OnboardingPage(
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

  final _i5.Key? key;

  @override
  String toString() {
    return 'OnboardingRouteArgs{onResult: $onResult, key: $key}';
  }
}
