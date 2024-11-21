import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/gen/assets.gen.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/refresh_indicator_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/services/device_info/device_info_manager.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:flow_zero_waste/src/profile/presentation/logics/cubit/profile_cubit.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/components/section_title.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/components/stat_row.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/licenses_widget.dart'
    as licenses;
import 'package:flow_zero_waste/src/profile/presentation/widgets/profile_badges.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Profile Page
@RoutePage()
class ProfilePage extends StatelessWidget {
  /// Default constructor
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = context.l10n;
    final page = context.watch<PageProvider>();

    return Scaffold(
      appBar: AppBarStyled(
        title: translations.profile,
      ),
      body: RefreshIndicatorStyled(
        onRefresh: () => context.read<ProfileCubit>().loadProfileStats(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(page.spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              const Align(child: ProfileBadges()),
              SectionTitle(title: translations.profileSettings),
              ProfileOption(
                icon: Icons.edit,
                title: translations.profileEditProfile,
              ),
              ProfileOption(
                icon: Icons.language_outlined,
                title: translations.profileChangeLanguage,
                onTap: () => context.router.push(const LanguageRoute()),
              ),
              ProfileOption(
                icon: Icons.gesture_sharp,
                title: translations.profileCustomizeTheme,
                onTap: () => context.router.push(const ThemeChangeRoute()),
              ),
              ProfileOption(
                icon: Icons.card_giftcard,
                title: translations.profileVouchers,
              ),
              ProfileOption(
                icon: Icons.notifications,
                title: translations.profileNotifications,
              ),
              ProfileOption(
                icon: Icons.logout,
                title: translations.profileLogOut,
                onTap: () => context.read<AuthProvider>().removeUserData(),
              ),
              const SizedBox(height: 24),
              SectionTitle(title: translations.profileCommunity),
              ProfileOption(
                icon: Icons.book_outlined,
                title: translations.kickoff,
                onTap: () => context.router.push(
                  OnboardingRoute(
                    onResult: ({success}) => context.router.navigate(
                      const AppNavigationRoute(
                        children: [
                          ProfileRoute(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ProfileOption(
                icon: Icons.article,
                title: translations.profileBlog,
                onTap: () =>
                    launchUrl(Uri.parse('https://flowzerowaste.com/blog')),
              ),
              ProfileOption(
                icon: Icons.store,
                title: translations.profileRegisterLocal,
                onTap: () => launchUrl(
                    Uri.parse('https://flowzerowaste.com/register-local')),
              ),
              ProfileOption(
                icon: Icons.recommend,
                title: translations.profileRecommendPlace,
                onTap: () =>
                    launchUrl(Uri.parse('https://flowzerowaste.com/recommend')),
              ),
              const SizedBox(height: 24),
              SectionTitle(title: translations.profileSupport),
              ProfileOption(
                icon: Icons.help,
                title: translations.profileHelp,
                onTap: () =>
                    launchUrl(Uri.parse('https://flowzerowaste.com/help')),
              ),
              ProfileOption(
                icon: Icons.info,
                title: translations.profileHowItWorks,
                onTap: () => launchUrl(
                    Uri.parse('https://flowzerowaste.com/how-it-works')),
              ),
              ProfileOption(
                icon: Icons.gavel,
                title: translations.profileLegal,
                onTap: () =>
                    launchUrl(Uri.parse('https://flowzerowaste.com/legal')),
              ),
              ProfileOption(
                icon: Icons.article,
                title: translations.profileLicenses,
                onTap: () async {
                  final packageInfo =
                      await locator<DeviceInfoManager>().package;
                  if (!context.mounted) return;
                  licenses.showLicensePage(
                    context: context,
                    title: Text(
                      translations.profileLicenses,
                      style: context.textTheme.headlineSmall,
                    ),
                    applicationIcon: CircleAvatar(
                      backgroundImage: AssetImage(
                        Assets.icons.flowLogoProduction.path,
                      ),
                    ),
                    applicationLegalese:
                        '© ${DateTime.now().year} Radosław Sienkiewicz',
                    applicationName: packageInfo.appName,
                    applicationVersion: packageInfo.version,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
