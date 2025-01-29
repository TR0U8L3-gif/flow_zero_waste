import 'dart:math';

import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/src/browse/presentation/widgets/product_widget.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/recommended_shops_section.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget({
    required this.shop,
    required this.products,
    this.onShopLike,
    this.onProductOrder,
    super.key,
  });

  final Shop shop;
  final List<Product> products;
  final void Function(String id)? onShopLike;
  final void Function(List<Product> products)? onProductOrder;

  @override
  Widget build(BuildContext context) {
    final page = context.read<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: SizedBox(
            width: page.size.width,
            child: ShopCard(
              shopData: ShopData(
                id: shop.id,
                title: shop.name,
                localization: shop.localization,
                startDate: shop.startDate,
                endDate: shop.endDate,
                description: shop.description,
                imageUrl: shop.imageUrl,
                isLiked: shop.isLiked,
              ),
              height: double.infinity,
              borderRadius: borderRadius,
              onShopLikeTap: onShopLike,
            ),
          ),
        ),
        SizedBox(height: page.spacing),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length - 1,
          itemBuilder: (context, index) {
            final productList =
                _getRandomProducts(products, index + shop.rating.toInt());
            return Padding(
              padding: EdgeInsets.only(bottom: page.spacing),
              child: GestureDetector(
                onTap: () async {
                  final result = await showModalBottomSheet<List<Product>>(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return ProductWidget(
                        products: productList,
                        borderRadius: borderRadius,
                      );
                    },
                  );
                  if (result != null) {
                    onProductOrder?.call(result);
                  }
                },
                child: ProductCard(
                  borderRadius: borderRadius,
                  products: productList,
                  index: index + 1,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<Product> _getRandomProducts(List<Product> products, int index) {
    final result = <Product>[];
    final randomLength = Random(422 + index).nextInt(products.length) + 1;

    final productsCpy = List<Product>.from(products);
    for (var i = 0; i < randomLength; i++) {
      final indexObject = Random(422 + index).nextInt(productsCpy.length);
      final object = productsCpy[indexObject];
      productsCpy.remove(object);
      result.add(object);
    }
    return result;
  }
}

/// Order card widget
class ProductCard extends StatelessWidget {
  /// Default constructor
  const ProductCard({
    required this.products,
    required this.borderRadius,
    required this.index,
    super.key,
  });

  /// Product data
  final List<Product> products;

  /// Border radius
  final BorderRadius borderRadius;

  final int index;

  @override
  Widget build(BuildContext context) {
    final allergens =
        products.map((product) => product.allergens).expand((e) => e).toSet();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ' #$index',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      height: 1.2,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            for (final product in products) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    // Product image
                    ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.network(
                        product.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.broken_image,
                          size: 80,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Order details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (allergens.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: allergens
                        .map(
                          (allergen) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Chip(
                              label: Text(allergen),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${context.l10n.price} ${products.first.price} ${context.l10n.currency}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // Text(
                //   '${context.l10n.quantity} ${products.first.quantity}',
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
