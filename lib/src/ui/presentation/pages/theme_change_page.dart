import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/accessibility/text/text_headline.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/nav_bar.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flow_zero_waste/core/enums/text_enum.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/num_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/ui/presentation/logics/text_scale_provider.dart';
import 'package:flow_zero_waste/src/ui/presentation/logics/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Change Theme
@RoutePage()
class ThemeChangePage extends StatelessWidget {
  /// Default constructor
  const ThemeChangePage({super.key});

  void _changeCounter(BuildContext context, double value) {
    if (!context.mounted) return;

    var counter = context.read<TextScaleProvider>().textScaleFactor;
    counter += value;
    counter = counter.roundToPlaces(2);
    context.read<TextScaleProvider>().setTextScaleFactor(counter);
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.l10n;
    final page = context.watch<PageProvider>();
    final themeProvider = context.read<ThemeProvider>();
    final textScaleProvider = context.watch<TextScaleProvider>();
    return Scaffold(
      appBar: NavBar(
        title: context.l10n.profileCustomizeTheme,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: page.spacing),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 36),
                Align(
                  child: Text(
                    '${translations.themeCurrentTextScaleFactor} '
                    '(${textScaleProvider.textScale.name}):',
                  ),
                ),
                Align(
                  child: Text(
                    '${textScaleProvider.textScaleFactor}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 12),
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
                  translations.themeDisplayStylesDescription,
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
                TextHeadline(
                  translations.themeHeadlinesDescription,
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
                  translations.themeTitlesDescription,
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
                  translations.themeBodyStylesDescription,
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
                  translations.themeLabelStylesDescription,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 32),
                FloatingActionButton(
                  heroTag: 'decrement_text_scale',
                  onPressed: () => _changeCounter(context, -0.1),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.text_decrease_rounded),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: 'reset_text_scale',
                  onPressed: () {
                    context.read<TextScaleProvider>().setTextScaleFactor(1);
                  },
                  tooltip: 'Reset',
                  child: Transform.scale(
                    scale: textScaleProvider.textScaleFactor,
                    child: const Icon(Icons.text_format_rounded),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: 'increment_text_scale',
                  onPressed: () => _changeCounter(context, 0.1),
                  tooltip: 'Increment',
                  child: const Icon(Icons.text_increase_rounded),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 32),
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
                  child: Icon(
                    themeProvider.brightness.isDark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
