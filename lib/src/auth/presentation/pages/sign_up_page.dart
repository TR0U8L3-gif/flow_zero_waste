import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/helpers/validators/email_validator.dart';
import 'package:flow_zero_waste/core/helpers/validators/password_validator.dart';
import 'package:flow_zero_waste/core/helpers/validators/phone_validator..dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// SignUpPage is a StatefulWidget for user registration
@RoutePage()
class SignUpPage extends StatefulWidget {
  /// SignUpPage constructor
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = context.read<PageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.registerButton),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: page.spacing),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: context.l10n.nameLabel,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? context.l10n.nameRequired : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: context.l10n.emailLabel,
                  ),
                  validator: emailValidator,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: context.l10n.phoneLabel,
                  ),
                  validator: phoneValidator,
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: context.l10n.passwordLabel,
                  ),
                  obscureText: true,
                  validator: passwordValidator,
                ),
                TextFormField(
                  controller: _repeatPasswordController,
                  decoration: InputDecoration(
                    labelText: context.l10n.repeatPasswordLabel,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return context.l10n.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.l),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      locator<AuthProvider>().register(
                        name: _nameController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                        password: _passwordController.text,
                      ).then((value) {
                        if(!context.mounted) return;
                        context.router.navigate(const SignInRoute());
                      });
                    }
                  },
                  child: Text(context.l10n.registerButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
