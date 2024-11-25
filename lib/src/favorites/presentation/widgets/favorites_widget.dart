import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/recommended_shops_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _shopsItemsEmpty = 4;

/// shops section
class FavoritesWidget extends StatelessWidget {
  /// Default constructor
  const FavoritesWidget({
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
      child: GridView.builder(
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
    );
  }
}
