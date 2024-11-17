import 'package:flutter/material.dart';

/// Navigation bar
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  /// Default constructor
  const NavBar({
    required this.title,
    super.key,
  });

  /// Title
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
