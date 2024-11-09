import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main page for auth feature
/// this page provides navigation for login and register
@RoutePage()
class AuthNavigationPage extends StatelessWidget implements AutoRouteWrapper {
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

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthCubit>(),
      child: this,
    );
  }
}
