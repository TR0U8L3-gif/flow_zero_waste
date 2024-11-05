import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Onboarding tab indicator
class OnboardingTabIndicator extends StatelessWidget {
  /// Default constructor for OnboardingTabIndicator
  const OnboardingTabIndicator({
    required this.radius,
    super.key,
  });

  /// Height of the indicator
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
