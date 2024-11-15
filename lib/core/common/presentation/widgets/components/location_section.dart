import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.location_on,
          color: context.colorScheme.primary,
        ),
        Text(
          localization ?? translations.location_selectLocation,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
    
            TextButton(
              onPressed: onLocationChange,
              child: Text(translations.change),
            ),
      ],
    );
  }
}
