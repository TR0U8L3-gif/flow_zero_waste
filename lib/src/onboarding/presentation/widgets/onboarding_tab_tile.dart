import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/accessibility/semantic_texts.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/text_outline.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/enums/text_enum.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/num_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/helpers/calculations/image_cache_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Onboarding tab tile
class OnboardingTabTile extends StatelessWidget {
  /// Default constructor
  const OnboardingTabTile({
    required this.headline,
    required this.description,
    required this.cropPage,
    this.last,
    this.imageAsset,
    this.imageUrl,
    this.imageTitle,
    super.key,
  });

  /// Image asset
  final String? imageAsset;

  /// Image url
  final String? imageUrl;

  /// Image title
  final String? imageTitle;

  /// Headline
  final String headline;

  /// Description
  final String description;

  /// Is last
  final void Function()? last;

  /// Crop page
  final bool cropPage;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final containImage = imageAsset != null || imageUrl != null;

    final controller = ScrollController();

    return RawScrollbar(
      thumbVisibility: true,
      controller: controller,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.s2,
        vertical: AppSize.s,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(page.spacing),
        child: Align(
          child: SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: page.spacing),
              child: Column(
                children: [
                  SizedBox(height: cropPage ? page.spacing : AppSize.xxxl),
                  if (containImage)
                    _Image(
                      imageTitle: imageTitle ?? '',
                      imageAsset: imageAsset,
                      imageUrl: imageUrl,
                    ),
                  if (containImage) const SizedBox(height: AppSize.l),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: page.spacing),
                    child: _Text(headline: headline, description: description),
                  ),
                  if (last != null) const SizedBox(height: AppSize.l),
                  if (last != null)
                    FilledButton.tonal(
                      onPressed: last,
                      child: Text(
                        context.l10n.allClear.toLowerCase(),
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  SizedBox(height: cropPage ? page.spacing : AppSize.xxxl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.imageTitle,
    this.imageAsset,
    this.imageUrl,
  }) : assert(
          imageAsset != null || imageUrl != null,
          'Image asset or image url must be provided',
        );

  /// Image asset
  final String? imageAsset;

  /// Image url
  final String? imageUrl;

  /// Image title
  final String imageTitle;
  @override
  Widget build(BuildContext context) {
    final page = context.read<PageProvider>();
    final isMediumOrLess = page.layoutSize <= PageLayoutSize.medium;
    return AspectRatio(
      aspectRatio: isMediumOrLess ? 1.24 : 2.48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(page.spacing),
        child: Container(
          width: double.infinity,
          color: context.colorScheme.primaryContainer,
          child: Stack(
            children: [
              if (imageUrl != null)
                SizedBox.expand(
                  child: Image.network(
                    excludeFromSemantics: true,
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.expand(),
                    cacheWidth: ImageCacheSize.calculate(
                      context,
                      page.size.width,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return SizedBox.expand(
                        child: ShimmerRectangle(
                          borderRadius: page.spacing,
                          opacity: 0.4,
                          backgroundColor: context.colorScheme.primaryContainer,
                        ),
                      );
                    },
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return AnimatedOpacity(
                        duration:
                            const Duration(milliseconds: AppSize.durationSmall),
                        opacity: frame == null ? 0 : 1,
                        child: child,
                      );
                    },
                  ),
                )
              else if (imageAsset != null)
                SizedBox.expand(
                  child: Image.asset(
                    excludeFromSemantics: true,
                    imageAsset!,
                    fit: BoxFit.cover,
                    cacheWidth: ImageCacheSize.calculate(
                      context,
                      page.size.width,
                    ),
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.expand(),
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return AnimatedOpacity(
                        duration:
                            const Duration(milliseconds: AppSize.durationSmall),
                        opacity: frame == null ? 0 : 1,
                        child: child,
                      );
                    },
                  ),
                ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: page.spacing,
                    bottom: page.spacing,
                  ),
                  child: TextOutline(
                    text: imageTitle,
                    textStyle: context.textTheme.displayLarge?.copyWith(
                      color: context.colorScheme.surface,
                      height: 1.56,
                    ),
                    strokeWidth: AppSize.s2,
                    strokeColor: context.colorScheme.onSurface
                        .withOpacity(AppSize.xxxl.fraction),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    required this.headline,
    required this.description,
  });

  /// Headline
  final String headline;

  /// Description
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextHeadline(
            headline,
            textSize: TextSize.medium,
            headingLevel: HeadingLevel.h1,
            textAlign: TextAlign.center,
            height: 1.1,
          ),
          const SizedBox(height: AppSize.m),
          Text(
            description,
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
