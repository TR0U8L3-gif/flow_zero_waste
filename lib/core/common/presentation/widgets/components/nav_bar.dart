import 'package:flutter/material.dart';

/// Navigation bar
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  /// Default constructor
  const NavBar({
    required this.text,
    super.key,
  });

  /// Text
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
