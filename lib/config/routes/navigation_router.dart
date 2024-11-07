import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/routes/guards/onboarding_guard.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:injectable/injectable.dart';

/// NavigationRouter is a class that extends the RootStackRouter class
@singleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class NavigationRouter extends RootStackRouter {
  /// Default constructor
  NavigationRouter({required OnboardingGuard onboardingGuard})
      : _onboardingGuard = onboardingGuard;

  final OnboardingGuard _onboardingGuard;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MyHomeRoute.page,
        ),
        AutoRoute(
          page: MainRoute.page,
        ),
        AutoRoute(
          page: OnboardingRoute.page,
        ),
        AutoRoute(
          page: MaterialBuilderRoute.page,
        ),
        AutoRoute(
          page: AppNavigationRoute.page,
          initial: true,
          guards: [
            _onboardingGuard,
          ],
          children: [
            AutoRoute(
              page: DiscoverRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: BrowseRoute.page,
            ),
            AutoRoute(
              page: FavoritesRoute.page,
            ),
            AutoRoute(
              page: OrdersRoute.page,
            ),
            AutoRoute(
              page: ProfileRoute.page,
            ),
          ],
        ),
      ];
}
