import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:injectable/injectable.dart';

/// ShopMapper
@singleton
class ShopMapper extends Mapper<ShopModel, Shop> {
  @override
  Shop from(ShopModel object) {
    return Shop(
      id: object.id,
      name: object.name,
      imageUrl: object.imageUrl,
      description: object.description,
      endDate: DateTime.parse(object.endDate),
      isLiked: object.isLiked,
      localization: object.localization,
      startDate: DateTime.parse(object.startDate),
      rating: object.rating,
    );
  }

  @override
  ShopModel to(Shop object) {
    return ShopModel(
      id: object.id,
      name: object.name,
      imageUrl: object.imageUrl,
      description: object.description,
      endDate: object.endDate.toIso8601String(),
      isLiked: object.isLiked,
      localization: object.localization,
      startDate: object.startDate.toIso8601String(),
      rating: object.rating,
    );
  }
}
