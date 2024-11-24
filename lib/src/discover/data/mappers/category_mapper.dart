import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/discover/data/models/category_model.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/category.dart';
import 'package:injectable/injectable.dart';

/// CategoryMapper
@singleton
class CategoryMapper extends Mapper<CategoryModel, Category> {
  @override
  Category from(CategoryModel object) {
    return Category(
      id: object.id,
      name: object.name,
      imageUrl: object.imageUrl,
    );
  }

  @override
  CategoryModel to(Category object) {
    return CategoryModel(
      id: object.id,
      name: object.name,
      imageUrl: object.imageUrl,
    );
  }
}
