import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Stat Row
class StatRow extends StatelessWidget {
  /// Default constructor
  const StatRow({
    required this.title,
    required this.value,
    this.icon,
    this.borderRadiusValue,
    this.paddingValue,
    this.iconSize,
    super.key,
  });

  /// Title
  final String title;

  /// Value
  final String value;

  /// Icon
  final IconData? icon;

  /// border radius value
  final double? borderRadiusValue;

  /// padding value
  final double? paddingValue;

  /// icon size
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: paddingValue ?? AppSize.s),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusValue ?? AppSize.m),
      ),
      child: Padding(
        padding: EdgeInsets.all(paddingValue ?? AppSize.s),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: paddingValue ?? AppSize.s),
            if (icon != null)
              Icon(
                icon,
                size: iconSize ?? AppSize.xl,
                color: context.colorScheme.primary,
              ),
            if (icon != null) SizedBox(width: paddingValue ?? AppSize.m),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium,
                ),
                Text(
                  value,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(width: paddingValue ?? AppSize.s),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const ProfileOption(
      {super.key, required this.icon, required this.title, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
