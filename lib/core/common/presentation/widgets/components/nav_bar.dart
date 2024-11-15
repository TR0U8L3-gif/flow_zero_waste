import 'package:flow_zero_waste/core/common/presentation/widgets/styled/app_bar_styled.dart';
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
    return AppBarStyled(
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
