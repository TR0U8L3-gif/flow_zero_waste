import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Main page for auth feature
/// this page provides navigation for login and register 
@RoutePage()
class AuthNavigationPage extends StatelessWidget {
  /// Default constructor 
  const AuthNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: AutoRouter(),
      ),
    );
  }
}
