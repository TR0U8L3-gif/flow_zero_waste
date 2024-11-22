import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/scrollbar_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AuthPage is a StatelessWidget for authentication
@RoutePage()
class AuthPage extends StatelessWidget {
  /// AuthPage constructor
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final page = context.read<PageProvider>();
    return Scaffold(
      body: ScrollbarStyled(
        child: Align(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: page.spacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSize.l),
                  Text(
                    context.l10n.appName,
                    style: context.textTheme.displayLarge?.copyWith(
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: AppSize.s),
                  Text(
                    context.l10n.appNameSlogan,
                    style: context.textTheme.headlineMedium?.copyWith(
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: AppSize.xxxl),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: page.spacing),
                    child: Text(
                      context.l10n.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(height: AppSize.m),
                  ElevatedButton(
                    onPressed: () => context.router.push(const SignInRoute()),
                    child: Text(context.l10n.loginButton),
                  ),
                  const SizedBox(height: AppSize.s),
                  OutlinedButton(
                    onPressed: () => context.router.push(const SignUpRoute()),
                    child: Text(
                      context.l10n.registerButton,
                    ),
                  ),
                  const SizedBox(height: AppSize.l),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
