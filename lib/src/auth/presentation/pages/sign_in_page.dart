import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/styled/app_bar_styled.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/styled/scrollbar_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/helpers/validators/email_validator.dart';
import 'package:flow_zero_waste/core/helpers/validators/password_validator.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/cubit/auth_cubit.dart';
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
    final authCubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, state) {
        if (!state.isListenable) return;

        if (state.isNavigatable) {
          (state as NavigatableLogicState).navigate(context);
          return;
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: context.colorScheme.error),
              ),
              backgroundColor: context.colorScheme.errorContainer,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBarStyled(
          title: Text(context.l10n.loginButton),
        ),
        body: ScrollbarStyled(
          child: Align(
            child: SingleChildScrollView(
              child: SizedBox(
                width: AppSize.layoutCompact.max,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: page.spacing),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSize.l),
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
                          validator: (value) => passwordValidatorIsEmpty(
                            value,
                            passwordIsRequired: context.l10n.passwordRequired,
                          ),
                        ),
                        const SizedBox(height: AppSize.l),
                        BlocBuilder<AuthCubit, AuthState>(
                          bloc: authCubit,
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                if (state is AuthLoading) return;
                                if (_formKey.currentState!.validate()) {
                                  if (FocusScope.of(context).hasFocus) {
                                    FocusScope.of(context).unfocus();
                                  }
                                  authCubit.login(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                }
                              },
                              child: state is AuthLoading
                                  ? const SizedBox(
                                      height: AppSize.m,
                                      width: AppSize.m,
                                      child: CircularProgressIndicator(
                                        strokeCap: StrokeCap.round,
                                        strokeWidth: AppSize.s2,
                                      ),
                                    )
                                  : Text(context.l10n.loginButton),
                            );
                          },
                        ),
                        const SizedBox(height: AppSize.l),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
