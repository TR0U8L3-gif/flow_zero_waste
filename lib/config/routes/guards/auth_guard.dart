import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:injectable/injectable.dart';

/// Guard that checks if the user is authenticated
@singleton
class AuthGuard extends AutoRouteGuard {
  /// Default constructor
  AuthGuard({required AuthProvider authProvider})
      : _authProvider = authProvider;

  final AuthProvider _authProvider;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authProvider.isLoggedIn) {
      resolver.next();
    } else {
      router.replaceAll([
        const AuthNavigationRoute(),
      ]);
    }
  }
}
