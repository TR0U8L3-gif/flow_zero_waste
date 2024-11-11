import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/routes/guards/auth_guard.dart';
import 'package:flow_zero_waste/config/routes/guards/onboarding_guard.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:injectable/injectable.dart';

/// NavigationRouter is a class that extends the RootStackRouter class
@singleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class NavigationRouter extends RootStackRouter {
  /// Default constructor
  NavigationRouter({
    required OnboardingGuard onboardingGuard,
    required AuthGuard auth,
  })  : _onboardingGuard = onboardingGuard,
        _auth = auth;

  final OnboardingGuard _onboardingGuard;
  final AuthGuard _auth;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppNavigationRoute.page,
          initial: true,
          guards: [_onboardingGuard, _auth],
          children: [
            AutoRoute(
              initial: true,
              page: DiscoverRoute.page,
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
        AutoRoute(
          page: AuthNavigationRoute.page,
          children: [
            AutoRoute(
              page: AuthRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: SignInRoute.page,
            ),
            AutoRoute(
              page: SignUpRoute.page,
            ),
          ],
        ),
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
      ];
}
