import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flutter/material.dart';

/// ScrollbarStyled is a StatelessWidget for scrollbar
class ScrollbarStyled extends StatelessWidget {
  /// ScrollbarStyled constructor
  const ScrollbarStyled({
    this.controller,
    this.child,
    super.key,
  });

  /// Scroll controller
  final ScrollController? controller;

  /// Child widget
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbVisibility: true,
      controller: controller,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.s2,
        vertical: AppSize.s,
      ),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
