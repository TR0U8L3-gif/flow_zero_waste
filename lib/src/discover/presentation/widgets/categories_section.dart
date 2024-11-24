import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/text_outline.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/helpers/calculations/image_cache_size.dart';
import 'package:flow_zero_waste/core/helpers/images/image_builders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _categoriesSectionHeight = 64.0;
const _categoryCardWidth = 192.0;
const _categoriesItemsEmpty = 4;

/// Categories section
class CategoriesSection extends StatelessWidget {
  /// Default constructor
  const CategoriesSection({
    required this.categories,
    this.onCategoryTap,
    super.key,
  });

  /// List of categories
  final List<CategoryData>? categories;

  /// Callback for category tap
  final void Function(String categoryTitle)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);

    if (categories == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.categoriesTitle,
          style: context.textTheme.headlineSmall,
        ),
        SizedBox(height: page.spacingHalf),
        ClipRRect(
          borderRadius: borderRadius,
          child: SizedBox(
            height: _categoriesSectionHeight,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories!.isNotEmpty
                  ? categories!.length
                  : _categoriesItemsEmpty,
              separatorBuilder: (context, index) =>
                  SizedBox(width: page.spacing),
              itemBuilder: (context, index) {
                if (categories!.isEmpty) {
                  return Container(
                    width: _categoryCardWidth,
                    height: _categoriesSectionHeight,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: context.colorScheme.primaryContainer,
                    ),
                    child: ShimmerRectangle(
                      borderRadius: borderRadius,
                    ),
                  );
                } else {
                  final category = categories![index];
                  return GestureDetector(
                    onTap: () => onCategoryTap?.call(category.title),
                    child: CategoryCard(
                      categoryData: category,
                      borderRadius: borderRadius,
                      height: _categoriesSectionHeight,
                      width: _categoryCardWidth,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Category card
class CategoryCard extends StatelessWidget {
  /// Default constructor
  const CategoryCard({
    required this.categoryData,
    required this.height,
    required this.width,
    required this.borderRadius,
    super.key,
  });

  /// Card height
  final double height;

  /// Card width
  final double width;

  /// Category data
  final CategoryData categoryData;

  /// Border radius
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.colorScheme.secondaryContainer,
          gradient: RadialGradient(
            colors: [
              context.colorScheme.secondaryContainer,
              context.colorScheme.secondary,
            ],
            center: Alignment.topCenter,
            radius: 8,
          ),
        ),
        child: Stack(
          children: [
            if (categoryData.imageUrl != null)
              SizedBox.expand(
                child: Image.network(
                  categoryData.imageUrl!,
                  fit: BoxFit.cover,
                  cacheWidth: ImageCacheSize.calculate(
                    context,
                    _categoryCardWidth,
                  ),
                  errorBuilder: errorBuilder,
                  loadingBuilder: loadingBuilder,
                  frameBuilder: frameBuilder,
                ),
              ),
            Align(
              child: Padding(
                padding: const EdgeInsets.all(AppSize.s),
                child: TextOutline(
                  categoryData.title,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.primary,
                  ),
                  strokeColor: context.colorScheme.onPrimary,
                  maxLines: 1,
                  strokeWidth: AppSize.s4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category data class
class CategoryData {
  /// Default constructor
  CategoryData({
    required this.title,
    this.imageUrl,
  });

  /// Category title
  final String title;

  /// Image URL
  final String? imageUrl;
}
