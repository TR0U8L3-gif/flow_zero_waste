import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
/// StatelessWidget that displays a styled RefreshIndicator.
class RefreshIndicatorStyled extends StatelessWidget {
  /// Default constructor
  const RefreshIndicatorStyled({
    required this.child,
    required this.onRefresh,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge, 
    super.key,
  });

  /// Child widget
  final Widget child;
  /// Function to call when refreshing
  final Future<void> Function() onRefresh;
  /// Trigger mode
  final RefreshIndicatorTriggerMode triggerMode;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: AppSize.xl,
      backgroundColor: context.colorScheme.onPrimary,
      color: context.colorScheme.primary,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
