import 'package:flow_zero_waste/core/common/presentation/logics/providers/scaffold_page_provider.dart';
import 'package:flow_zero_waste/core/enums/container_enum.dart';
import 'package:flow_zero_waste/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Scaffold page for Responsive UI
/// with resizable containers secondary, primary, tertiary.
class ScaffoldPage extends StatelessWidget {
  /// Creates a scaffold page.
  const ScaffoldPage({
    super.key,
    this.showPaddingTop = false,
    this.showPaddingBottom = false,
    this.showPaddingLeft = false,
    this.showPaddingRight = false,
    this.primaryContainer,
    this.secondaryContainer,
    this.tertiaryContainer,
    this.containerMinWidth,
    this.spacing,
  });

  /// Whether to show padding top.
  final bool showPaddingTop;

  /// Whether to show padding bottom.
  final bool showPaddingBottom;

  /// Whether to show padding left.
  final bool showPaddingLeft;

  /// Whether to show padding right.
  final bool showPaddingRight;

  /// The minimum width of the container.
  final double? containerMinWidth;

  /// The spacing between the containers.
  final double? spacing;

  /// The primary container.
  final Widget? primaryContainer;

  /// The secondary container.
  final Widget? secondaryContainer;

  /// The tertiary container.
  final Widget? tertiaryContainer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ChangeNotifierProvider(
        create: (context) => ScaffoldPageProvider()
          ..initialize(
            paddingTop: showPaddingTop,
            paddingBottom: showPaddingBottom,
            paddingLeft: showPaddingLeft,
            paddingRight: showPaddingRight,
            containerMinWidth: containerMinWidth,
            providedSpacing: spacing,
            secondaryContainerVisible: secondaryContainer != null,
            tertiaryContainerVisible: tertiaryContainer != null,
          ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<ScaffoldPageProvider>(context, listen: false)
                ..updatePageSize(
                  Size(constraints.maxWidth, constraints.maxHeight),
                )
                ..initialize(providedSpacing: spacing);
            });
            return Consumer<ScaffoldPageProvider>(
              builder: (context, page, child) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: showPaddingTop ? page.spacing : 0,
                    bottom: showPaddingBottom ? page.spacing : 0,
                    left: showPaddingLeft ? page.spacing : 0,
                    right: showPaddingRight ? page.spacing : 0,
                  ),
                  child: MouseRegion(
                    cursor: page.isResizing
                        ? SystemMouseCursors.resizeLeftRight
                        : MouseCursor.defer,
                    child: Row(
                      children: [
                        if (page.isSecondaryContainerAccessible)
                          _ScaffoldContainerExtended(
                            isResizing: page.isResizing,
                            spacing: page.spacing,
                            containerWidth: page.secondaryContainerWidth,
                            isVisible: page.isSecondaryContainerVisible,
                            isSecondary: true,
                            isTertiary: false,
                            isSecondaryResizing: page.isSecondaryResizing,
                            isTertiaryResizing: page.isTertiaryResizing,
                            maximizing: page.maximizing,
                            minimizing: page.minimizing,
                            onResizeStart: (details) {
                              page.resizeContainerStart(
                                ContainerResize.secondary,
                              );
                            },
                            onResizeUpdate: (details) {
                              page.resizeContainerUpdate(
                                details.delta.dx,
                                details.delta.dy,
                              );
                            },
                            onResizeEnd: (details) {
                              page.resizeContainerEnd();
                            },
                            child: secondaryContainer,
                          ),
                        Expanded(
                          child: _ScaffoldContainerPrimary(
                            isResizing: page.isResizing,
                            containerWidth: double.infinity,
                            spacing: page.spacing,
                            child: primaryContainer,
                          ),
                        ),
                        if (page.isTertiaryContainerAccessible)
                          _ScaffoldContainerExtended(
                            containerWidth: page.tertiaryContainerWidth,
                            spacing: page.spacing,
                            isSecondary: false,
                            isTertiary: true,
                            isVisible: page.isTertiaryContainerVisible,
                            isResizing: page.isResizing,
                            isSecondaryResizing: page.isSecondaryResizing,
                            isTertiaryResizing: page.isTertiaryResizing,
                            minimizing: page.minimizing,
                            maximizing: page.maximizing,
                            onResizeStart: (details) {
                              page.resizeContainerStart(
                                ContainerResize.tertiary,
                              );
                            },
                            onResizeUpdate: (details) {
                              page.resizeContainerUpdate(
                                details.delta.dx,
                                details.delta.dy,
                              );
                            },
                            onResizeEnd: (details) {
                              page.resizeContainerEnd();
                            },
                            child: tertiaryContainer,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ScaffoldContainerPrimary extends StatelessWidget {
  const _ScaffoldContainerPrimary({
    required this.isResizing,
    required this.containerWidth,
    required this.spacing,
    this.child,
  });

  final bool isResizing;
  final double containerWidth;
  final double spacing;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(spacing / 2),
      child: IgnorePointer(
        ignoring: isResizing,
        child: Opacity(
          opacity: isResizing ? 0.5 : 1.0,
          child: SizedBox(
            height: double.infinity,
            width: containerWidth,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _ScaffoldContainerExtended extends StatelessWidget {
  const _ScaffoldContainerExtended({
    required this.isResizing,
    required this.isSecondary,
    required this.isSecondaryResizing,
    required this.isTertiary,
    required this.isTertiaryResizing,
    required this.maximizing,
    required this.minimizing,
    required this.containerWidth,
    required this.spacing,
    required this.isVisible,
    this.onResizeStart,
    this.onResizeUpdate,
    this.onResizeEnd,
    this.child,
  });

  final bool isResizing;
  final bool isSecondary;
  final bool isSecondaryResizing;
  final bool isTertiary;
  final bool isTertiaryResizing;

  final double maximizing;
  final double minimizing;

  final double containerWidth;
  final double spacing;
  final bool isVisible;

  final Widget? child;

  final void Function(DragStartDetails)? onResizeStart;
  final void Function(DragUpdateDetails)? onResizeUpdate;
  final void Function(DragEndDetails)? onResizeEnd;

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? SizedBox(
            height: double.infinity,
            width: containerWidth + spacing,
            child: Row(
              children: [
                if (isTertiary)
                  Container(
                    height: double.infinity,
                    width: spacing,
                    color: Colors.transparent,
                    child: _ResizeHandle(
                      isLeft: false,
                      isResizing: isResizing,
                      isCurrentResizing: isTertiaryResizing,
                      maximizing: maximizing,
                      minimizing: minimizing,
                      onResizeStart: onResizeStart,
                      onResizeUpdate: onResizeUpdate,
                      onResizeEnd: onResizeEnd,
                      width: spacing,
                    ),
                  ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(spacing / 2),
                  child: IgnorePointer(
                    ignoring: isResizing,
                    child: Opacity(
                      opacity: isResizing ? 0.5 : 1.0,
                      child: SizedBox(
                        height: double.infinity,
                        width: containerWidth,
                        child: child,
                      ),
                    ),
                  ),
                ),
                if (isSecondary)
                  Container(
                    height: double.infinity,
                    width: spacing,
                    color: Colors.transparent,
                    child: _ResizeHandle(
                      isLeft: true,
                      isResizing: isResizing,
                      isCurrentResizing: isSecondaryResizing,
                      maximizing: maximizing,
                      minimizing: minimizing,
                      onResizeStart: onResizeStart,
                      onResizeUpdate: onResizeUpdate,
                      onResizeEnd: onResizeEnd,
                      width: spacing,
                    ),
                  ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class _ResizeHandle extends StatelessWidget {
  const _ResizeHandle({
    required this.isResizing,
    required this.isLeft,
    required this.isCurrentResizing,
    required this.maximizing,
    required this.minimizing,
    required this.width,
    this.onResizeStart,
    this.onResizeUpdate,
    this.onResizeEnd,
  });

  final bool isLeft;

  final bool isResizing;
  final bool isCurrentResizing;

  final double maximizing;
  final double minimizing;

  final double width;
  final void Function(DragStartDetails)? onResizeStart;
  final void Function(DragUpdateDetails)? onResizeUpdate;
  final void Function(DragEndDetails)? onResizeEnd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: width / 2),
          child: SizedBox(
            width: width,
            height: width,
            child: isResizing
                ? Align(
                    child: Opacity(
                      opacity: (isResizing == isCurrentResizing
                          ? maximizing.mapValue(0, 1, 0.5, 1)
                          : 0.5),
                      child: Transform.scale(
                        scale: 1 +
                            (isResizing == isCurrentResizing ? maximizing : 0),
                        child: Icon(
                          isLeft
                              ? Icons.chevron_right_rounded
                              : Icons.chevron_left_rounded,
                          color: theme.onSurfaceVariant,
                          size: width * 0.72,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: width / 2),
          child: GestureDetector(
            excludeFromSemantics: true,
            onPanStart: onResizeStart,
            onPanUpdate: onResizeUpdate,
            onPanEnd: onResizeEnd,
            child: MouseRegion(
              cursor: isResizing ? MouseCursor.defer : SystemMouseCursors.click,
              child: Container(
                height: width * 3,
                width: width / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width / 2),
                  color: isResizing ? theme.onSurfaceVariant : theme.outline,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: width / 2),
          child: SizedBox(
            width: width,
            height: width,
            child: isResizing
                ? Align(
                    child: Opacity(
                      opacity: (isResizing == isCurrentResizing
                          ? minimizing.mapValue(0, 1, 0.5, 1)
                          : 0.5),
                      child: Transform.scale(
                        scale: 1 +
                            (isResizing == isCurrentResizing ? minimizing : 0),
                        child: Icon(
                          isLeft
                              ? Icons.chevron_left_rounded
                              : Icons.chevron_right_rounded,
                          color: theme.onSurfaceVariant,
                          size: width * 0.72,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
