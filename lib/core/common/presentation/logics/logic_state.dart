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
}

/// Mark state as buildable
///
/// This works with BlocConsumer's `listenWhen` and `buildWhen` parameters.
mixin BuildableLogicState on BaseLogicState {
  @override
  bool get isBuildable => true;
  @override
  bool get isListenable => false;
}

/// Mark state as listenable
///
/// This works with BlocConsumer's `listenWhen` and `buildWhen` parameters.
mixin ListenableLogicState on BaseLogicState {
  @override
  bool get isBuildable => false;
  @override
  bool get isListenable => true;
}

/// This enforces fields on ArthurStateNavigatable mixin.
abstract class BaseNavigatableLogicState {
  /// Navigation type
  abstract final NavigationType type;

  /// Navigation route
  ///
  /// leave `null` for maybePop and back
  /// pass `List<PageRouteInfo<dynamic>>` for pushAll and replaceAll
  /// set to `PageRouteInfo<dynamic>` for push, replace, and navigate
  abstract final Object? route;
}

/// Mark state as listenable
///
/// This works with BlocConsumer's `listenWhen` and `buildWhen` parameters.
/// This specialized mixin handles generic navigation
mixin NavigatableLogicState on BaseLogicState
    implements BaseNavigatableLogicState {
  @override
  bool get isBuildable => false;
  @override
  bool get isListenable => true;

  /// navigate to the specified route
  Future<dynamic> navigate(BuildContext context) async {
    const sender = 'NavigatableLogicState.navigate';
    const descriptionNavigationType = 'Invalid navigation type';
    const descriptionRoute = 'Invalid route parameter';

    switch (type.input) {
      case NavigationInput.none:
        if (route == null) {
          switch (type) {
            case NavigationType.back:
              return context.router.back();
            case NavigationType.maybePop:
              return context.router.maybePop();
            default:
              throw NavigateException(
                sender: sender,
                description: descriptionNavigationType,
                navigationType: type.toString(),
                routeRuntimeType: 'null',
              );
          }
        } else {
          throw NavigateException(
            sender: sender,
            description: '$descriptionRoute, proper route type should be null',
            navigationType: type.toString(),
            routeRuntimeType: route.runtimeType.toString(),
          );
        }
      case NavigationInput.route:
        if (route != null && route is PageRouteInfo<dynamic>) {
          switch (type) {
            case NavigationType.push:
              return context.router.push(route! as PageRouteInfo<dynamic>);
            case NavigationType.replace:
              return context.router.replace(route! as PageRouteInfo<dynamic>);
            case NavigationType.navigate:
              return context.router.navigate(route! as PageRouteInfo<dynamic>);
            default:
              throw NavigateException(
                sender: sender,
                description: descriptionNavigationType,
                navigationType: type.toString(),
                routeRuntimeType: 'PageRouteInfo<dynamic>',
              );
          }
        } else {
          throw NavigateException(
            sender: sender,
            description: '$descriptionRoute, proper route type should be '
                'PageRouteInfo<dynamic>',
            navigationType: type.toString(),
            routeRuntimeType: route.runtimeType.toString(),
          );
        }
      case NavigationInput.list:
        if (route != null && route is List<PageRouteInfo<dynamic>>) {
          switch (type) {
            case NavigationType.pushAll:
              return context.router
                  .pushAll(route! as List<PageRouteInfo<dynamic>>);
            case NavigationType.replaceAll:
              return context.router
                  .replaceAll(route! as List<PageRouteInfo<dynamic>>);
            default:
              throw NavigateException(
                sender: sender,
                description: descriptionNavigationType,
                navigationType: type.toString(),
                routeRuntimeType: 'List<PageRouteInfo<dynamic>>',
              );
          }
        } else {
          throw NavigateException(
            sender: sender,
            description: '$descriptionRoute, proper route type should be '
                'List<PageRouteInfo<dynamic>>',
            navigationType: type.toString(),
            routeRuntimeType: route.runtimeType.toString(),
          );
        }
    }
  }
}
