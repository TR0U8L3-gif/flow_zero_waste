import 'package:auto_route/auto_route.dart';


class AuthGuard extends AutoRouteGuard {
  final AuthService authService; // Dependency injection of an AuthService

  AuthGuard(this.authService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authService.isLoggedIn) {
      resolver.next();
    } else {
      // If the user is not logged in, replace the route with the Login page
      router.pushAndPopUntil(
        LoginRoute(), // Replace with your Login route
        predicate: (_) => false, // Remove all previous routes
      );
    }
  }
}
