import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/nav_bar.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/src/auth/presentation/logics/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.l10n;
    return Scaffold(
      appBar: NavBar(
        title: translations.profile,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const SizedBox(height: 16),
            const Align(child: ProfileStats()),
            const SizedBox(height: 24),
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
              icon: Icons.article,
              title: translations.profileBlog,
            ),
            ProfileOption(
              icon: Icons.store,
              title: translations.profileRegisterLocal,
            ),
            ProfileOption(
              icon: Icons.recommend,
              title: translations.profileRecommendPlace,
            ),
            const SizedBox(height: 24),
            SectionTitle(title: translations.profileSupport),
            ProfileOption(
              icon: Icons.help,
              title: translations.profileHelp,
            ),
            ProfileOption(
              icon: Icons.info,
              title: translations.profileHowItWorks,
            ),
            ProfileOption(
              icon: Icons.gavel,
              title: translations.profileLegal,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<AuthProvider>().user?.name ?? '';
    final email = context.watch<AuthProvider>().user?.email ?? '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            userName.isNotEmpty ? userName[0].toUpperCase() : '?',
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.l10n;
    final page = context.watch<PageProvider>();
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        StatRow(
          title: translations.profileAvoidedCO2Emissions,
          value: '25 ppmv',
          icon: Icons.cloud_outlined,
        ),
        StatRow(
          title: translations.profileMoneySaved,
          value: '200 zł',
          icon: Icons.attach_money,
        ),
        StatRow(
          title: translations.profileOrderCount,
          value: '15',
          icon: Icons.shopping_cart_outlined,
        ),
        StatRow(
          title: translations.profilePointsCollected,
          value: '1200',
          icon: Icons.star_outline,
        ),
        StatRow(
          title: translations.profileTreesPlanted,
          value: '3',
          icon: Icons.park_outlined,
        ),
      ],
    );
  }
}

class StatRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const StatRow({
    Key? key,
    required this.title,
    required this.value,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 32.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              if (icon != null) const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const ProfileOption(
      {Key? key, required this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
