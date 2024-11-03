// ignore_for_file: avoid_print, use_build_context_synchronously, require_trailing_commas, prefer_single_quotes, always_put_required_named_parameters_first, public_member_api_docs, lines_longer_than_80_chars, prefer_int_literals

import 'package:auto_route/annotations.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/pages/responsive_ui/container_page.dart';
import 'package:flow_zero_waste/core/common/presentation/pages/responsive_ui/navigation_page.dart';
import 'package:flow_zero_waste/core/common/presentation/pages/responsive_ui/scaffold_page.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/accessibility/text/text_headline.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flow_zero_waste/core/enums/text_enum.dart';
import 'package:flow_zero_waste/core/extensions/build_context_extension.dart';
import 'package:flow_zero_waste/core/extensions/num_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/ui/presentation/logics/text_scale_provider.dart';
import 'package:flow_zero_waste/src/ui/presentation/logics/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedItem = 0;

  void changeSelectedIndex(int value) {
    setState(() {
      selectedItem = value;
    });
  }

  final navItems = const <NavItem>[
    NavItem(
      title: 'Home',
      icon: Icons.home,
      tooltip: 'Navigate to Home',
    ),
    NavItem(
      title: 'Profile',
      icon: Icons.person,
      tooltip: 'Navigate to Profile',
    ),
    NavItem(
      title: 'Settings',
      icon: Icons.settings,
      tooltip: 'Navigate to Settings',
    ),
    NavItem(
      title: 'Powiadomienia',
      icon: Icons.notifications,
      tooltip: 'Navigate to Notifications',
    ),
    NavItem(
      title: 'Help',
      icon: Icons.help,
      tooltip: 'Navigate to Help',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final pageProvider = context.watch<PageProvider>();
    final textScaleProvider = context.watch<TextScaleProvider>();
    const minColumnWidth = 48.0;

    return Scaffold(
      backgroundColor: themeProvider.themeData.colorScheme.surfaceContainerHigh,
      body: SafeArea(
        top: !pageProvider.navBarType.isBottom,
        child: NavigationPage(
          navItems: navItems,
          selectedIndex: selectedItem,
          onSelectedIndex: changeSelectedIndex,
          textScaler: textScaleProvider.textScaler,
          child: ScaffoldPage(
            showPaddingTop: !pageProvider.navBarType.isBottom && context.mediaQuery.padding.top < pageProvider.spacing,
            showPaddingBottom: !pageProvider.navBarType.isBottom && context.mediaQuery.padding.bottom < pageProvider.spacing,
            showPaddingRight: !pageProvider.navBarType.isBottom && context.mediaQuery.padding.right < pageProvider.spacing,
            containerMinWidth: minColumnWidth,
            spacing: pageProvider.spacing,
            primaryContainer: const WcagPage(title: 'Primary Container'),
            secondaryContainer: ContainerPage(
              backgroundColor:
                  themeProvider.themeData.colorScheme.secondaryContainer,
              minimizedWidth: minColumnWidth,
              title: Text(
                'Secondary Container',
                style: themeProvider.themeData.textTheme.headlineSmall?.copyWith(
                  color: themeProvider.themeData.colorScheme.onSecondaryContainer,
                ),
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: themeProvider.themeData.colorScheme.primaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => print("ElevatedButton: received Click 1"),
                      onLongPress: () =>
                          print("ElevatedButton: received Long Press 1"),
                      child: Text(
                        'Click Me ${navItems.elementAtOrNull(selectedItem)}  $selectedItem',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => print("ElevatedButton: received Click 2"),
                      child: Text(
                        'Click Me ${pageProvider.size}  ${pageProvider.layoutSize}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            tertiaryContainer: ContainerPage(
                backgroundColor:
                    themeProvider.themeData.colorScheme.tertiaryContainer,
                minimizedWidth: minColumnWidth,
                title: Text(
                  'Tertiary Container',
                  style:
                      themeProvider.themeData.textTheme.headlineSmall?.copyWith(
                    color:
                        themeProvider.themeData.colorScheme.onTertiaryContainer,
                  ),
                ),
                child: const WcagPage(title: 'Tertiary Container')),
          ),
        ),
      ),
    );
  }
}

class WcagPage extends StatelessWidget {
  const WcagPage({super.key, required this.title});

  final String title;

  void changeCounter(BuildContext context, double value) {
    if (!context.mounted) return;

    var counter = context.read<TextScaleProvider>().textScaleFactor;
    counter += value;
    counter = counter.roundToPlaces(2);
    context.read<TextScaleProvider>().setTextScaleFactor(counter);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final textScaleProvider = context.watch<TextScaleProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 120),
                Align(
                  child: Text(
                    'Current text scale factor (${textScaleProvider.textScale.name}):',
                  ),
                ),
                Align(
                  child: Text(
                    '${textScaleProvider.textScaleFactor}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 120),
                const SizedBox(height: 48),
                Text(
                  'displayLarge',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'displayMedium',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'displaySmall',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 36),
                Text(
                  'Display styles are reserved for short, important text or numerals. They work best on large screens.',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 48),
                const TextHeadline(
                  'headlineLarge',
                  textSize: TextSize.large,
                  headingLevel: HeadingLevel.h1,
                ),
                const SizedBox(height: 12),
                const TextHeadline(
                  'headlineMedium',
                  textSize: TextSize.medium,
                  headingLevel: HeadingLevel.h2,
                ),
                const SizedBox(height: 12),
                const TextHeadline(
                  'headlineSmall',
                  textSize: TextSize.small,
                  headingLevel: HeadingLevel.h3,
                ),
                const SizedBox(height: 36),
                const TextHeadline(
                  'Headlines are best-suited for short, high-emphasis text on smaller screens.',
                  textSize: TextSize.small,
                  headingLevel: HeadingLevel.h3,
                ),
                const SizedBox(height: 48),
                Text(
                  'titleLarge',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'titleMedium',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'titleSmall',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 36),
                Text(
                  'Titles are smaller than headline styles, and should be used for medium-emphasis text that remains relatively short.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 48),
                Text(
                  'bodyLarge',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'bodyMedium',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'bodySmall',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 36),
                Text(
                  'Body styles are used for longer passages of text in your app.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 48),
                Text(
                  'labelLarge',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'labelMedium',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'labelSmall',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  'Label styles are smaller, utilitarian styles, used for things like the text inside components.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 32),
            FloatingActionButton(
              heroTag: 'increment_text_scale',
              onPressed: () => changeCounter(context, 0.2),
              tooltip: 'Increment',
              child: const Icon(Icons.text_increase_rounded),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'reset_text_scale',
              onPressed: () {
                context.read<TextScaleProvider>().setTextScaleFactor(1.0);
              },
              tooltip: 'Reset',
              child: Transform.scale(
                  scale: textScaleProvider.textScaleFactor,
                  child: const Icon(Icons.text_format_rounded)),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'decrement_text_scale',
              onPressed: () => changeCounter(context, -0.2),
              tooltip: 'Decrement',
              child: const Icon(Icons.text_decrease_rounded),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'high_contrast',
              onPressed: () {
                themeProvider.contrast = Contrast.high;
              },
              tooltip: 'High Contrast',
              child: const Icon(Icons.brightness_high),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'medium_contrast',
              onPressed: () {
                themeProvider.contrast = Contrast.medium;
              },
              tooltip: 'Medium Contrast',
              child: const Icon(Icons.brightness_medium),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'standard_contrast',
              onPressed: () {
                themeProvider.contrast = Contrast.standard;
              },
              tooltip: 'Standard Contrast',
              child: const Icon(Icons.brightness_low),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'dark_mode',
              onPressed: () {
                themeProvider.brightness = themeProvider.brightness.isDark
                    ? Brightness.light
                    : Brightness.dark;
              },
              tooltip: 'theme mode',
              child: Icon(themeProvider.brightness.isDark
                  ? Icons.dark_mode
                  : Icons.light_mode),
            ),
          ],
        ),
      ),
    );
  }
}
