part of 'auth_cubit.dart';

/// default Auth state
sealed class AuthState extends BaseLogicState with EquatableMixin {
  const AuthState();

  @override
  List<Object?> get props => [runtimeType];
}

/// Auth idle state
final class AuthIdle extends AuthState with BuildableLogicState {}

/// Auth loading state
final class AuthLoading extends AuthState with BuildableLogicState {}

/// Auth registered state
final class AuthRegistered extends AuthState with NavigatableLogicState {
  @override
  NavigationAction get action => const NavigationActionSingleRoute(
        type: NavigationType.replace,
        route: SignInRoute(),
      );
  
  @override
  List<Object?> get props => [runtimeType, action];
}

/// Auth logged in state
final class AuthLoggedIn extends AuthState with NavigatableLogicState {
  @override
  NavigationAction get action => const NavigationActionMultipleRoutes(
        type: NavigationType.replaceAll,
        routes: [AppNavigationRoute()],
      );
  
  @override
  List<Object?> get props => [runtimeType, action];
}

/// Auth error state
final class AuthError extends AuthState with ListenableLogicState {
  /// Auth error constructor
  const AuthError({required this.message});
  
  /// Error message
  final String message;

  @override
  List<Object?> get props => [runtimeType, message];
}
