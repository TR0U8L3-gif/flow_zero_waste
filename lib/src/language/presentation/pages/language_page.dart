import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/config/l10n/l10n.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/scrollbar_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Language Page
@RoutePage()
class LanguagePage extends StatelessWidget {
  /// Default constructor
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = context.l10n;
    final page = context.watch<PageProvider>();
    final languageProvider = context.watch<LanguageProvider>();
    final currentLanguage = languageProvider.currentLanguage;

    return Scaffold(
      appBar: AppBarStyled(title: translations.profileChangeLanguage),
      body: ScrollbarStyled(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: page.spacing),
          child: Align(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: L10n.supportedLocales.length,
              itemBuilder: (context, index) {
                final locale = L10n.supportedLocales[index];
                final isSelected = locale == currentLanguage;

                return Padding(
                  padding: EdgeInsets.only(bottom: page.spacing),
                  child: Align(
                    child: SizedBox(
                      width: AppSize.layoutCompact.max,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(page.spacing),
                        ),
                        tileColor: context.colorScheme.secondaryContainer,
                        title: Text(
                          translations.languageName(locale.languageCode),
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                        onTap: () => languageProvider
                            .changeLanguage(locale.languageCode),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
