import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Onboarding footer
class OnboardingFooter extends StatelessWidget {
  /// Default constructor for OnboardingFooter
  const OnboardingFooter({
    required this.height,
    required this.width,
    this.next,
    this.back,
    this.child,
    super.key,
  });

  /// Height of the footer
  final double height;

  /// Width of the footer
  final double width;

  /// on Next clicked function
  final void Function()? next;

  /// on Back clicked function
  final void Function()? back;

  /// child
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: back != null
                ? Align(
                    child: OutlinedButton(
                      // heroTag: 'onboarding_back',
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSize.s,
                        ),
                      ),
                      onPressed: back?.call,
                      child: Text(
                        context.l10n.back,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  )
                : const SizedBox.expand(),
          ),
          Flexible(
            flex: 2,
            child: child ?? const SizedBox.expand(),
          ),
          Flexible(
            child: next != null
                ? Align(
                    child: OutlinedButton(
                      onPressed: next?.call,
                      child: Text(
                        context.l10n.next,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  )
                : const SizedBox.expand(),
          ),
        ],
      ),
    );
  }
}
