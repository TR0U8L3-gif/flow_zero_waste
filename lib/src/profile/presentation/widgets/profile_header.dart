
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Profile Header
class ProfileHeader extends StatelessWidget {
  /// Default constructor
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<AuthProvider>().user?.name ?? '';
    final email = context.watch<AuthProvider>().user?.email ?? '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: context.colorScheme.primary,
          child: Align(
            alignment: const Alignment(-0.1,-0.1),
            child: Text(
              userName.isNotEmpty ? userName[0].toUpperCase() : '?',
              style: context.textTheme.headlineLarge?.copyWith(
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
