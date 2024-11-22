import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flutter/material.dart';

/// Section Title
class SectionTitle extends StatelessWidget {
  /// Default constructor
  const SectionTitle({
    required this.title,
    this.padding,
    super.key,
  });

  /// Title
  final String title;
  /// Padding
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: AppSize.s),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
