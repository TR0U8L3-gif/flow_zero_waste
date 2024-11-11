import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/core/common/data/exceptions.dart';
import 'package:flow_zero_waste/core/enums/navigation_type_enum.dart';
import 'package:flutter/widgets.dart';

/// Base state that reduces boilerplate when trying to
/// distinguish buildable states from listenable states
///
/// BLoC/Cubit's root state should extend this and child states
/// should use [BuildableLogicState] or [ListenableLogicState] mixins.
@immutable
abstract class BaseLogicState {
  /// Default constructor
  const BaseLogicState();

  /// Whether the state is buildable
  abstract final bool isBuildable;

  /// Whether the state is listenable
  abstract final bool isListenable;

  /// Whether the state is navigatable
  abstract final bool isNavigatable;
}

/// Mark state as buildable
///
/// This works with BlocConsumer's `listenWhen` and `buildWhen` parameters.
mixin BuildableLogicState on BaseLogicState {
  @override
  bool get isBuildable => true;
  @override
  bool get isListenable => false;
  @override
  bool get isNavigatable => false;
}

/// Mark state as listenable
///
/// This works with BlocConsumer's `listenWhen` and `buildWhen` parameters.
mixin ListenableLogicState on BaseLogicState {
  @override
  bool get isBuildable => false;
  @override
  bool get isListenable => true;
  @override
  bool get isNavigatable => false;
}

/// Navigation action
sealed class NavigationAction {
  /// Default constructor
  const NavigationAction({
    required this.type,
  });

  /// Navigation type
  final NavigationType type;
}

/// Navigation action null
/// represents maybePop and back
class NavigationActionNull extends NavigationAction {
  /// Default constructor
  const NavigationActionNull({
    required super.type,
  });
}

/// Navigation action single route
/// represents push, replace, and navigate
class NavigationActionSingleRoute extends NavigationAction {
  /// Default constructor
  const NavigationActionSingleRoute({
    required super.type,
    required this.route,
  });

  /// Navigation route
  final PageRouteInfo<dynamic> route;
}

/// Navigation action multiple routes
/// represents pushAll and replaceAll
class NavigationActionMultipleRoutes extends NavigationAction {
  /// Default constructor
  const NavigationActionMultipleRoutes({
    required super.type,
    required this.routes,
  });

  /// Navigation routes
  final List<PageRouteInfo<dynamic>> routes;
}

/// Mark state as listenable
///
/// This works with BlocConsumer's `listenWhen` and `buildWhen` parameters.
/// This specialized mixin handles generic navigation
mixin NavigatableLogicState<T extends NavigationAction> on BaseLogicState {
  /// Navigation action
  abstract final T action;

  @override
  bool get isBuildable => false;
  @override
  bool get isListenable => true;
  @override
  bool get isNavigatable => true;

  /// navigate to the specified route
  Future<dynamic> navigate(BuildContext context) async {
    const error = 'Invalid navigation type';

    switch (action) {
      case NavigationActionNull():
        final navigation = action as NavigationActionNull;
        switch (navigation.type) {
          case NavigationType.back:
            return context.router.back();
          case NavigationType.maybePop:
            return context.router.maybePop();
          default:
            throw NavigateException(
              error: error,
              action: 'navigate',
              navigationType: navigation.type.name,
              routeRuntimeType: 'null',
            );
        }
      case NavigationActionSingleRoute():
        final navigation = action as NavigationActionSingleRoute;
        switch (navigation.type) {
          case NavigationType.push:
            return context.router.push(navigation.route);
          case NavigationType.replace:
            return context.router.replace(navigation.route);
          case NavigationType.navigate:
            return context.router.navigate(navigation.route);
          default:
            throw NavigateException(
              error: error,
              action: 'navigate',
              navigationType: navigation.type.name,
              routeRuntimeType: 'PageRouteInfo<dynamic>',
            );
        }
      case NavigationActionMultipleRoutes():
        final navigation = action as NavigationActionMultipleRoutes;
        switch (navigation.type) {
          case NavigationType.pushAll:
            return context.router.pushAll(navigation.routes);
          case NavigationType.replaceAll:
            return context.router.replaceAll(navigation.routes);
          default:
            throw NavigateException(
              error: error,
              action: 'navigate',
              navigationType: navigation.type.name,
              routeRuntimeType: 'List<PageRouteInfo<dynamic>>',
            );
        }
    }
  }
}
