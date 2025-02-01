// ignore_for_file: lines_longer_than_80_chars

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
import 'package:flow_zero_waste/src/profile/presentation/logics/profile_stats_cubit.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/components/section_title.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/components/stat_row.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/licenses_widget.dart'
    as licenses;
import 'package:flow_zero_waste/src/profile/presentation/widgets/profile_badges.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

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
        onRefresh: () => context.read<ProfileStatsCubit>().loadProfileStats(),
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
                onTap: () => context.router.push(
                  const ProfileChangeDataRoute(),
                ),
              ),
              ProfileOption(
                icon: Icons.language_outlined,
                title: translations.profileChangeLanguage,
                onTap: () => context.router.push(
                  const LanguageRoute(),
                ),
              ),
              ProfileOption(
                icon: Icons.gesture_sharp,
                title: translations.profileCustomizeTheme,
                onTap: () => context.router.push(
                  const ThemeChangeRoute(),
                ),
              ),
              // ProfileOption(
              //   icon: Icons.card_giftcard,
              //   title: translations.profileVouchers,
              // ),
              // ProfileOption(
              //   icon: Icons.notifications,
              //   title: translations.profileNotifications,
              // ),
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
                  Uri.parse('https://flowzerowaste.com/register-local'),
                ),
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
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicketScreen()),
                ),
              ),
              ProfileOption(
                icon: Icons.info,
                title: 'FAQ',
                onTap: () => launchUrl(
                  Uri.parse('https://flow-web-app-two.vercel.app/user#FAQ'),
                ),
              ),
              // ProfileOption(
              //   icon: Icons.gavel,
              //   title: translations.profileLegal,
              //   onTap: () =>
              //       launchUrl(Uri.parse('https://flowzerowaste.com/legal')),
              // ),
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

class TicketScreen extends StatefulWidget {
  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  var ticketsList = <(String, String, List<String>)>[
    (
      'Unable to process payment for order',
      'fa38eea9-d551-4c62-8bd8-31811194c732',
      [
        'user: Hi, I had a problem with processing a payment for order number XXX. Could you help me with this?',
        "support: Hello! I'm sorry to hear about the issue with your payment. Could you provide more details about what happened? For example, did you see an error message?",
        'user: Yes, the payment seemed to fail, but the amount was deducted from my account. The order status still shows as pending.',
        'support: Thank you for the details. I’ll check our system to see if the payment went through. Can you also confirm the payment method you used (e.g., card, PayPal)?',
        'user: I used my credit card for this payment.',
        'support: Got it. I’m currently investigating the issue. Please allow me a few minutes to check. In the meantime, I’ll ensure your order is prioritized for review.',
        'user: Thank you!',
        'support: Thank you for your patience! I’ve reviewed your order and can confirm that the payment did not fully process. We will issue a refund for the amount deducted, and you can try placing the order again. The refund will take 3–5 business days to reflect in your account.',
        'user: Thanks for the update. I’ll wait for the refund and try again later.',
        'support: You’re welcome! Please feel free to reach out if you need further assistance. Have a great day!',
      ],
    ),
    (
      'Refund status',
      '25b851bb-59a2-4003-ba9b-fbb694c53e77',
      [
        'user: Hi, I noticed a payment issue with my order number XXX. Can you help?',
        'support: Hello! I’m sorry to hear that. We will check the issue and process a refund if necessary. Please allow us some time to investigate.',
        'user: Thank you! How long will the refund process take?',
        'support: Refunds typically take 3-5 business days to reflect in your account. We’ll notify you once the process is complete.',
      ],
    ),
  ];

  void showSupportTicketModal(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Support Ticket',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: messageController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String title = titleController.text.trim();
                  String message = messageController.text.trim();
                  if (title.isNotEmpty && message.isNotEmpty) {
                    setState(() {
                      ticketsList.add(
                        (
                          title,
                          const Uuid().v4(),
                          ['user: $message'],
                        ),
                      );
                    });
                    Navigator.pop(context);
                  }
                },
                child: Center(child: Text('Submit Ticket')),
              ),
            ],
          ),
        );
      },
    );
  }

  void showChatModal(BuildContext context, List<String> messages) {
    final TextEditingController messageController = TextEditingController();
    final messageList = List<String>.from(messages);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            top: MediaQuery.of(context).padding.top + 64.0,
          ),
          child: StatefulBuilder(
            builder: (contextX, setStateX) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        children: messageList.map((msg) {
                          bool isUser = msg.startsWith('user:');
                          return Align(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: isUser ? 0 : 32.0,
                                left: isUser ? 32.0 : 0,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4.0),
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? contextX.colorScheme.primary
                                      : contextX.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  msg.replaceFirst(
                                      RegExp(r'^(user|support): '), ''),
                                  style: TextStyle(
                                    color: isUser
                                        ? contextX.colorScheme.onPrimary
                                        : contextX
                                            .colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const Divider(),
                  TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: 'Type a message...',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          String message = messageController.text.trim();
                          if (message.isNotEmpty) {
                            setStateX(() {
                              messageList.add('user: $message');
                            });
                            setState(() {
                              ticketsList = ticketsList.map((ticket) {
                                if (ticket.$3 == messages) {
                                  return (ticket.$1, ticket.$2, messageList);
                                }
                                return ticket;
                              }).toList();
                            });
                            messageController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyled(
        title: "Help",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final ticket in ticketsList) ...[
            InkWell(
              onTap: () => showChatModal(context, ticket.$3),
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.$1,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      SizedBox(height: 8),
                      Text(
                        ticket.$2,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        ticket.$3.isNotEmpty
                            ? ticket.$3.last
                            : 'No messages yet',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => showSupportTicketModal(context),
              child: const Text('Create New Ticket'),
            ),
          ),
        ],
      ),
    );
  }
}
