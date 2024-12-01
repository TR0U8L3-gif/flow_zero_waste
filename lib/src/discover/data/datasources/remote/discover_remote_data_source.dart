import 'package:flow_zero_waste/src/discover/data/models/banner_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/category_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/offer_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';
import 'package:flow_zero_waste/src/orders/data/models/product_model.dart';

/// Discover remote data source
abstract class DiscoverRemoteDataSource {
  /// get banners
  Future<List<BannerModel>> getBanners({
    required String languageCode,
  });

  /// get shops
  Future<List<ShopModel>> getShops({
    required String languageCode,
    required double latitude,
    required double longitude,
  });

  /// get categories
  Future<List<CategoryModel>> getCategories({
    required String languageCode,
  });

  /// get offers
  Future<List<OfferModel>> getOffers({
    required String languageCode,
    required double latitude,
    required double longitude,
  });

  /// like shop
  Future<void> likeShop(String id);

  /// get shop with products
  Future<(ShopModel, List<ProductModel>)> getShopWithProducts({
    required String languageCode,
    required String shopId,
  });

  /// place order
  Future<void> placeOrder({
    required String shopId,
    required String productId,
    required int quantity,
    required String languageCode,
  });
}
