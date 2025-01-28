import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/date_time_extension.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/helpers/images/image_builders.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _shopsItemsEmpty = 6;

class BrowseWidget extends StatelessWidget {
  const BrowseWidget({required this.shops, super.key, this.onShopTap});

  final List<Shop>? shops;
  final void Function(String id)? onShopTap;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: shops!.isNotEmpty ? shops?.length : _shopsItemsEmpty,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: page.layoutSize >= PageLayoutSize.medium ? 2 : 1,
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
              shop: shop,
              height: double.infinity,
              borderRadius: borderRadius,
            ),
          );
        }
      },
    );
  }
}

class ShopCard extends StatelessWidget {
  /// Default constructor
  const ShopCard({
    required this.shop,
    required this.height,
    required this.borderRadius,
    super.key,
  });

  final Shop shop;

  final double height;

  final BorderRadius borderRadius;

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
                    shop.imageUrl,
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
                          shop.name,
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: page.spacingHalf,
                        vertical: page.spacingHalf,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(page.spacing),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: page.spacingHalf,
                          vertical: page.spacingQuarter,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: context.colorScheme.onTertiaryContainer,
                            ),
                            SizedBox(width: page.spacingHalf),
                            Text(
                              '${shop.rating}',
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: context.colorScheme.onTertiaryContainer,
                              ),
                            ),
                          ],
                        ),
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
                            shop.description,
                            style: context.textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            shop.localization,
                            style: context.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          // Text(
                          //   '${context.l10n.available}: '
                          //   '${shop.startDate.ddMM} | '
                          //   '${shop.startDate.HHmm} - '
                          //   '${shop.endDate.HHmm}',
                          //   style: context.textTheme.bodyMedium,
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 1,
                          // ),
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
