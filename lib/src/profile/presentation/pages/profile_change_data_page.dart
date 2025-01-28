import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/scrollbar_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/helpers/validators/email_validator.dart';
import 'package:flow_zero_waste/core/helpers/validators/phone_validator.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:flow_zero_waste/src/profile/domain/responses/profile_responses.dart';
import 'package:flow_zero_waste/src/profile/presentation/logics/profile_edit_cubit.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Page for changing user data
@RoutePage()
class ProfileChangeDataPage extends StatefulWidget implements AutoRouteWrapper {
  /// Default constructor
  const ProfileChangeDataPage({super.key});

  @override
  State<ProfileChangeDataPage> createState() => _UserEditPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ProfileEditCubit>(),
      child: this,
    );
  }
}

class _UserEditPageState extends State<ProfileChangeDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthProvider>();
    if (auth.user?.name != null) {
      _nameController.text = auth.user!.name;
    }
    if (auth.user?.email != null) {
      _emailController.text = auth.user!.email;
    }
    if (auth.user?.phoneNumber != null) {
      _phoneController.text = auth.user!.phoneNumber;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final profileEditCubit = context.read<ProfileEditCubit>();
    return BlocConsumer<ProfileEditCubit, ProfileEditState>(
      bloc: profileEditCubit,
      listener: (context, state) {
        if (!state.isListenable) return;

        if (state.isNavigatable) {
          (state as NavigatableLogicState).navigate(context);
        }

        if (state is ProfileEditSuccess) {
          var successMessage = context.l10n.operationSuccessful;

          if (state.success is UpdatedProfileDataSuccess) {
            successMessage = context.l10n.userDataChangeSuccess;
          }
          if (state.success is ChangedPasswordSuccess) {
            successMessage = context.l10n.passwordChangeSuccess;
            _confirmPasswordController.clear();
            _currentPasswordController.clear();
            _newPasswordController.clear();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                successMessage,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: context.colorScheme.onPrimaryContainer),
              ),
              backgroundColor: context.colorScheme.primaryContainer,
            ),
          );
        }
        if (state is ProfileEditFailure) {
          var errorMessage = context.l10n.unexpectedError;

          if (state.failure is FailedToUpdateProfileDataFailure) {
            errorMessage = context.l10n.userDataChangeFailure;
          }
          if (state.failure is FailedToChangePasswordFailure) {
            errorMessage = context.l10n.passwordChangeFailure;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: context.colorScheme.onErrorContainer),
              ),
              backgroundColor: context.colorScheme.errorContainer,
            ),
          );
        }
      },
      builder: (context, state) {
        final isDataLoading =
            state is ProfileEditLoading && state.isDataChanged;
        final isPasswordLoading =
            state is ProfileEditLoading && state.isPasswordChanged;
        return Scaffold(
          appBar: AppBarStyled(
            title: context.l10n.profileEditProfile,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: page.spacing),
                          SectionTitle(title: context.l10n.changeUserData),
                          SizedBox(height: page.spacing),
                          IgnorePointer(
                            ignoring: isDataLoading,
                            child: Opacity(
                              opacity: isDataLoading ? 0.5 : 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Name field
                                  TextFormField(
                                    controller: _nameController,
                                    // initialValue: auth.user?.name,
                                    decoration: InputDecoration(
                                      labelText: context.l10n.nameLabel,
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                  ),
                                  SizedBox(height: page.spacing),
                                  // Email field
                                  TextFormField(
                                    controller: _emailController,
                                    // initialValue: auth.user?.email,
                                    decoration: InputDecoration(
                                      labelText: context.l10n.emailLabel,
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.email),
                                    ),
                                    validator: emailValidatorWithoutEmptyCheck,
                                  ),
                                  SizedBox(height: page.spacing),

                                  // Phone number field
                                  TextFormField(
                                    controller: _phoneController,
                                    // initialValue: auth.user?.phoneNumber,
                                    decoration: InputDecoration(
                                      labelText: context.l10n.phoneLabel,
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.phone),
                                    ),
                                    validator: phoneValidatorWithoutEmptyCheck,
                                  ),
                                  SizedBox(height: page.spacing),
                                  // Save button
                                  OutlinedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (FocusScope.of(context).hasFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        profileEditCubit.changeProfileData(
                                          name: _nameController.text,
                                          email: _emailController.text,
                                          phoneNumber: _phoneController.text,
                                        );
                                      }
                                    },
                                    child: isDataLoading
                                        ? const Icon(Icons.sync_outlined)
                                        : Text(context.l10n.saveChanges),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: page.spacingDouble),
                          SectionTitle(title: context.l10n.changePassword),
                          SizedBox(height: page.spacing),
                          IgnorePointer(
                            ignoring: isPasswordLoading,
                            child: Opacity(
                              opacity: isPasswordLoading ? 0.5 : 1,
                              child: Column(
                                children: [
                                  // Current password
                                  TextFormField(
                                    controller: _currentPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText:
                                          context.l10n.currentPasswordLabel,
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.lock),
                                    ),
                                  ),
                                  SizedBox(height: page.spacing),

                                  // New password
                                  TextFormField(
                                    controller: _newPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: context.l10n.passwordLabel,
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.lock_open),
                                    ),
                                  ),
                                  SizedBox(height: page.spacing),

                                  // Confirm new password
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText:
                                          context.l10n.repeatPasswordLabel,
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.lock_open),
                                    ),
                                    validator: (value) {
                                      if (value != _newPasswordController.text) {
                                        return context.l10n.passwordsDoNotMatch;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: page.spacing),
                                  OutlinedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (FocusScope.of(context).hasFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        profileEditCubit.changePassword(
                                          currentPassword:
                                              _currentPasswordController.text,
                                          newPassword:
                                              _newPasswordController.text,
                                          confirmPassword:
                                              _confirmPasswordController.text,
                                        );
                                      }
                                    },
                                    child: isPasswordLoading
                                        ? const Icon(Icons.sync_outlined)
                                        : Text(
                                            context.l10n.changePassword,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: page.spacingDouble),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
