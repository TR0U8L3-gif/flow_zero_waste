import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/date_time_extension.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/helpers/images/image_builders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _shopsItemsEmpty = 4;

/// shops section
class RecommendedShopsSection extends StatelessWidget {
  /// Default constructor
  const RecommendedShopsSection({
    required this.shops,
    super.key,
    this.onShopTap,
    this.onShopLikeTap,
  });

  /// shops
  final List<ShopData>? shops;

  /// Callback for shop tap
  final void Function(String shopId)? onShopTap;

  /// Callback for shop like tap
  final void Function(String shopId)? onShopLikeTap;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);

    if (shops == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.recommendedShops,
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(height: page.spacing),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shops!.isNotEmpty ? shops?.length : _shopsItemsEmpty,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    page.layoutSize >= PageLayoutSize.medium ? 2 : 1,
                childAspectRatio: 2,
                crossAxisSpacing: page.spacing,
                mainAxisSpacing: page.spacing,
              ),
              itemBuilder: (context, index) {
                if (shops!.isEmpty) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: ShimmerRectangle(
                      borderRadius: borderRadius,
                    ),
                  );
                } else {
                  final shop = shops![index];
                  return GestureDetector(
                    onTap: () => onShopTap?.call(shop.id),
                    child: ShopCard(
                      shopData: shop,
                      height: double.infinity,
                      borderRadius: borderRadius,
                      onShopLikeTap: onShopLikeTap,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// shop card
class ShopCard extends StatelessWidget {
  /// Default constructor
  const ShopCard({
    required this.shopData,
    required this.height,
    required this.borderRadius,
    this.onShopLikeTap,
    super.key,
  });

  /// shop data
  final ShopData shopData;

  /// shop height
  final double height;

  /// shop border radius
  final BorderRadius borderRadius;

  /// Callback for shop like tap
  final void Function(String shopId)? onShopLikeTap;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: context.colorScheme.surfaceContainer,
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    shopData.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: errorBuilder,
                    loadingBuilder: loadingBuilder,
                    frameBuilder: frameBuilder,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(page.spacing),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: page.spacing,
                          left: page.spacing,
                        ),
                        child: Text(
                          shopData.title,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(page.spacing),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          shopData.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: context.colorScheme.onTertiaryContainer,
                        ),
                        onPressed: () => onShopLikeTap?.call(shopData.id),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: page.spacing,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: page.spacingHalf,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            shopData.description,
                            style: context.textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            shopData.localization,
                            style: context.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            '${context.l10n.available}: '
                            '${shopData.startDate.ddMM} | '
                            '${shopData.startDate.HHmm} - '
                            '${shopData.endDate.HHmm}',
                            style: context.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
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

/// Data class to hold the shop information.
class ShopData {
  /// Creates an shop data object.
  ShopData({
    required this.id,
    required this.title,
    required this.localization,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.imageUrl,
    required this.isLiked,
  });

  /// shop id
  final String id;

  /// shop image URL
  final String imageUrl;

  /// shop title
  final String title;

  /// shop description
  final String description;

  /// shop localization
  final String localization;

  /// shop start date
  final DateTime startDate;

  /// shop end date
  final DateTime endDate;

  /// shop is liked
  final bool isLiked;
}
