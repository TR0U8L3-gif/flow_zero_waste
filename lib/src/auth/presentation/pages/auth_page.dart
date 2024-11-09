import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AuthPage is a StatelessWidget
@RoutePage()
class AuthPage extends StatelessWidget {
  /// AuthPage constructor
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    final page = context.read<PageProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: page.spacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.xxl),
                Text(
                  context.l10n.appName,
                  style: context.textTheme.displayLarge,
                ),
                const SizedBox(height: AppSize.s),
                Text(
                  context.l10n.welcomeMessage,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSize.xxl),
                ElevatedButton(
                  onPressed: () => context.router.push(SignInRoute()),
                  child: Text(context.l10n.loginButton),
                ),
                const SizedBox(height: AppSize.m),
                OutlinedButton(
                  onPressed: () => context.router.push(SignUpRoute()),
                  child: Text(context.l10n.registerButton),
                ),
                const SizedBox(height: AppSize.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
