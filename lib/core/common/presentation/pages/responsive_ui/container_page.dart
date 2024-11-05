import 'package:flutter/material.dart';

/// A container page widget for responsive Ui.
class ContainerPage extends StatelessWidget {
  /// Creates a container page widget.
  const ContainerPage({
    required this.minimizedWidth,
    required this.title,
    required this.backgroundColor,
    super.key,
    this.child,
  });

  /// The minimized width of the container.
  final double minimizedWidth;

  /// The title of the container.
  final Text title;

  /// The background color of the container.
  final Color backgroundColor;

  /// The child of the container.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width == 0) {
          return const SizedBox.shrink();
        }

        return Container(
          color: backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: () {
            if (width <= minimizedWidth) {
              return UnconstrainedBox(
                clipBehavior: Clip.hardEdge,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Align(
                    child: title,
                  ),
                ),
              );
            } else {
              return child;
            }
          }(),
        );
      },
    );
  }
}
