import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/category.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/get_categories.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/categories_section.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _categoriesSectionHeight = 64.0;
const _categoryCardWidth = 192.0;
const _categoriesItemsEmpty = 4;

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    this.onCategoryTap,
    super.key,
  });

  final void Function(String categoryTitle)? onCategoryTap;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Category>? categories = [];

  @override
  void initState() {
    super.initState();
    _initializeCategories();
  }

  void _initializeCategories() {
    // Fetch categories
    final languageCode =
        context.read<LanguageProvider>().currentLanguage.languageCode;
    locator<GetCategories>()
        .call(GetCategoriesParams(languageCode: languageCode))
        .then((value) {
      value.fold(
        (l) => setState(() {
          categories = null;
        }),
        (r) => setState(() => categories = r),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);

    if (categories == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: _categoriesSectionHeight,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories!.isNotEmpty
              ? categories!.length
              : _categoriesItemsEmpty,
          separatorBuilder: (context, index) => SizedBox(width: page.spacing),
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
                onTap: () => widget.onCategoryTap?.call(category.name),
                child: CategoryCard(
                  categoryData: CategoryData(
                    title: category.name,
                    imageUrl: category.imageUrl,
                  ),
                  borderRadius: borderRadius,
                  height: _categoriesSectionHeight,
                  width: _categoryCardWidth,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
