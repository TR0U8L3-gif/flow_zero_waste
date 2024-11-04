import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/src/onboarding/presentation/logics/onboarding_provider.dart';
import 'package:injectable/injectable.dart';

/// Onboarding guard
@lazySingleton
class OnboardingGuard extends AutoRouteGuard {
  /// Constructor for OnboardingGuard
  OnboardingGuard({
    required OnboardingProvider onboardingProvider,
  }) : _onboardingProvider = onboardingProvider;
  final OnboardingProvider _onboardingProvider;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final hasSeenOnboarding = _onboardingProvider.isOnboardingSeen;

    if (hasSeenOnboarding ) {
      resolver.next();
    } else {
      await resolver.redirect(
        OnboardingRoute(
          onResult: ({success}) {
            if (success ?? false) {
              _onboardingProvider.setOnboardingSeen();
            }
            resolver.next();
          },
        ),
      );
    }
  }
}
