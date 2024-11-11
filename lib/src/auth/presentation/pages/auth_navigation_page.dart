import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
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
    final page = context.watch<PageProvider>();
    final cropPage = page.layoutSize >= PageLayoutSize.expanded;

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerHigh,
      body: SafeArea(
        child: Align(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: cropPage ? page.spacing : 0,
            ),
            child: ClipRRect(
              borderRadius: !cropPage
                      ? BorderRadius.zero
                      : BorderRadius.circular(
                          page.spacing,
                        ),
              child: SizedBox(
                width: cropPage ? AppSize.layoutMedium.max : double.infinity,
                height: double.infinity,
                child: const AutoRouter(),
              ),
            ),
          ),
        ),
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
