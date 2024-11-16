import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Location section
/// Widget for selecting location
class LocationSection extends StatelessWidget {
  /// Default constructor
  const LocationSection({
    required this.localization,
    required this.onLocationChange,
    super.key,
  });

  /// Localization - string to display street itp
  final String? localization;

  /// Callback for location change
  final VoidCallback? onLocationChange;

  @override
  Widget build(BuildContext context) {
    final translations = context.l10n;
    final page = context.watch<PageProvider>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(page.spacingDouble),
      child: ColoredBox(
        color: context.colorScheme.secondaryContainer,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: page.spacing,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.location_on,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: page.spacingHalf),
              Expanded(
                child: Align(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      localization ?? translations.locationSelectLocation,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(width: page.spacingHalf),
              TextButton(
                onPressed: onLocationChange,
                child: Text(translations.change),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
