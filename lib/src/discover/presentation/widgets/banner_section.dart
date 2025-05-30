import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/text_outline.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/helpers/calculations/image_cache_size.dart';
import 'package:flow_zero_waste/core/helpers/images/image_builders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _bannerSectionHeight = 128.0;
const _bannerCardWidth = 256.0;
const _bannerItemsEmpty = 4;

/// Banners section
class BannersSection extends StatelessWidget {
  /// Default constructor
  const BannersSection({
    required this.banners,
    this.onBannerTap,
    super.key,
  });

  /// Banners
  final List<BannerData>? banners;

  /// Callback for banner tap
  final void Function(String bannerTitle)? onBannerTap;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);

    if (banners == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: _bannerSectionHeight,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: banners!.isNotEmpty ? banners!.length : _bannerItemsEmpty,
          separatorBuilder: (context, index) => SizedBox(width: page.spacing),
          itemBuilder: (context, index) {
            if (banners!.isEmpty) {
              return Container(
                width: _bannerCardWidth,
                height: _bannerSectionHeight,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: context.colorScheme.primaryContainer,
                ),
                child: ShimmerRectangle(
                  borderRadius: borderRadius,
                ),
              );
            } else {
              final banner = banners![index];
              return GestureDetector(
                onTap: () => onBannerTap?.call(banner.title),
                child: BannerCard(
                  bannerData: banner,
                  borderRadius: borderRadius,
                  height: _bannerSectionHeight,
                  width: _bannerCardWidth,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

/// Banner card
class BannerCard extends StatelessWidget {
  /// Default constructor
  const BannerCard({
    required this.bannerData,
    required this.height,
    required this.width,
    required this.borderRadius,
    super.key,
  });

  /// Banner height
  final double height;

  /// Banner width
  final double width;

  /// Image url
  final BannerData bannerData;

  /// Error builder
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          gradient: RadialGradient(
            colors: [
              context.colorScheme.primaryContainer,
              context.colorScheme.primary,
            ],
            center: Alignment.topCenter,
            radius: 8,
          ),
        ),
        child: Stack(
          children: [
            if (bannerData.imageUrl != null)
              Opacity(
                opacity: 0.9,
                child: SizedBox.expand(
                  child: Image.network(
                    bannerData.imageUrl!,
                    fit: BoxFit.cover,
                    cacheWidth: ImageCacheSize.calculate(
                      context,
                      _bannerCardWidth,
                    ),
                    errorBuilder: errorBuilder,
                    loadingBuilder: loadingBuilder,
                    frameBuilder: frameBuilder,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          context.colorScheme.primaryContainer.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(AppSize.m),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: AppSize.s,
                      right: AppSize.s,
                    ),
                    child: TextOutline(
                      bannerData.title,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      strokeWidth: 1,
                    ),
                  ),
                  if (bannerData.description != null)
                    Container(
                      color:
                          context.colorScheme.primaryContainer.withOpacity(0.6),
                      padding: const EdgeInsets.only(
                        left: AppSize.s,
                        right: AppSize.s,
                        bottom: AppSize.s2,
                      ),
                      alignment: Alignment.center,
                      child: TextOutline(
                        bannerData.description!,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        strokeWidth: 0.8,
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Baner data class to hold title and image url
class BannerData {
  /// Default constructor
  BannerData({
    required this.title,
    this.description,
    this.imageUrl,
  });

  /// Title
  final String title;

  /// Description
  final String? description;

  /// Image url
  final String? imageUrl;
}
