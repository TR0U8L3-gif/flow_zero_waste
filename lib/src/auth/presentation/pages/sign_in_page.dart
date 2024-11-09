import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/helpers/validators/email_validator.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// SignInPage is a StatefulWidget for user login
@RoutePage()
class SignInPage extends StatefulWidget {
  /// SignInPage constructor
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = context.read<PageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.loginButton),
      ),
      body: Align(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: page.spacing),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: context.l10n.emailLabel,
                      border: const OutlineInputBorder(),
                      icon: const Icon(Icons.email),
                    ),
                    validator: (value) => emailValidator(
                      value,
                      emailIsRequired: context.l10n.emailRequired,
                      emailNotValid: context.l10n.invalidEmail,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSize.l),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: context.l10n.passwordLabel,
                      border: const OutlineInputBorder(),
                      icon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: AppSize.l),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        locator<AuthProvider>()
                            .login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        )
                            .then((value) {
                          if (!context.mounted) return;
                          context.router.replaceAll([
                            const AppNavigationRoute(),
                          ]);
                        });
                      }
                    },
                    child: Text(context.l10n.loginButton),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
