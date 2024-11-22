import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/config/gen/assets.gen.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/constants/widgets_constants.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:flow_zero_waste/src/onboarding/presentation/widgets/onboarding_tab_indicator.dart';
import 'package:flow_zero_waste/src/onboarding/presentation/widgets/onboarding_tab_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Onboarding page
@RoutePage()
class OnboardingPage extends StatefulWidget {
  /// Default constructor
  const OnboardingPage({
    required this.onResult,
    super.key,
  });

  /// Onboarding page result function
  final void Function({bool? success}) onResult;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final tabLength = 3;
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: tabLength,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final cropPage = page.layoutSize >= PageLayoutSize.expanded;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceContainerHigh,
        body: SafeArea(
          child: Align(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: cropPage ? page.spacing : 0,
              ),
              child: Container(
                width: cropPage ? AppSize.layoutMedium.max : double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: !cropPage
                      ? null
                      : BorderRadius.circular(
                          page.spacing,
                        ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      if (page.layoutSize <= PageLayoutSize.expanded)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: page.layoutSize.isCompact ||
                                    page.layoutSize.isExpanded
                                ? 0
                                : page.spacing,
                          ),
                          child: const SizedBox(
                            height: kButtonHeightDefault,
                          ),
                        )
                      else
                        SizedBox(
                          height: page.spacing,
                        ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(page.spacing),
                            topRight: Radius.circular(page.spacing),
                          ),
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              for (var i = 0; i < tabLength; i++)
                                OnboardingTabTile(
                                  cropPage: cropPage,
                                  imageAsset: _getImageAssetUrl(i),
                                  imageTitle: _getDisplayText(i),
                                  headline: _getHeadlineText(i),
                                  description: _getBodyText(i),
                                  last: i == tabLength - 1
                                      ? () => widget.onResult(success: true)
                                      : null,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: cropPage ? 0 : page.spacing,
                        ),
                        child: OnboardingFooter(
                          width: double.infinity,
                          height: kOnboardingFooterHeight,
                          next: _tabController == null ||
                                  _tabController?.index == tabLength - 1
                              ? null
                              : () {
                                  if (_tabController == null) return;
                                  setState(() {
                                    _tabController!.animateTo(
                                      _tabController!.index + 1,
                                    );
                                  });
                                },
                          back: _tabController == null ||
                                  _tabController?.index == 0
                              ? null
                              : () {
                                  if (_tabController == null) return;
                                  setState(() {
                                    _tabController!.animateTo(
                                      _tabController!.index - 1,
                                    );
                                  });
                                },
                          child: TabBar(
                            controller: _tabController,
                            indicatorWeight: 0,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(page.spacing),
                              color: context.colorScheme.primaryContainer,
                            ),
                            dividerColor: Colors.transparent,
                            onTap: (value) {
                              if (_tabController == null) return;
                              setState(() {
                                _tabController!.animateTo(value);
                              });
                            },
                            tabs: [
                              for (var i = 0; i < tabLength; i++)
                                OnboardingTabIndicator(
                                  radius: page.spacing,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(
            vertical: page.layoutSize.isCompact ? 0 : page.spacing,
          ),
          child: SizedBox(
            height: kButtonHeightDefault,
            child: TextButton(
              onPressed: () => widget.onResult(success: true),
              child: Text(
                context.l10n.skip,
                style: context.textTheme.labelSmall,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }

  String _getDisplayText(int index) {
    switch (index) {
      case 0:
        return context.l10n.onboardingTitleDisplay1;
      case 1:
        return context.l10n.onboardingTitleDisplay2;
      case 2:
        return context.l10n.onboardingTitleDisplay3;
      default:
        return '';
    }
  }

  String _getHeadlineText(int index) {
    switch (index) {
      case 0:
        return context.l10n.onboardingTitleHeadline1;
      case 1:
        return context.l10n.onboardingTitleHeadline2;
      case 2:
        return context.l10n.onboardingTitleHeadline3;
      default:
        return '';
    }
  }

  String _getBodyText(int index) {
    switch (index) {
      case 0:
        return context.l10n.onboardingTitleBody1;
      case 1:
        return context.l10n.onboardingTitleBody2;
      case 2:
        return context.l10n.onboardingTitleBody3;
      default:
        return '';
    }
  }

  String _getImageAssetUrl(int index) {
    switch (index) {
      case 0:
        return Assets.images.zeroWasteFruitsAndVegetables.path;
      case 1:
        return Assets.images.greenEcoStore.path;
      case 2:
        return Assets.images.productOnPalette.path;
      default:
        return '';
    }
  }
}
