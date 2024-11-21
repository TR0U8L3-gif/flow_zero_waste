import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/src/profile/presentation/logics/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Profile Navigation Page
@RoutePage()
class ProfileNavigationPage extends StatelessWidget implements AutoRouteWrapper {
  /// Default constructor
  const ProfileNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
  
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ProfileCubit>()..loadProfileStats(),
      child: this,
    );
  }
}
