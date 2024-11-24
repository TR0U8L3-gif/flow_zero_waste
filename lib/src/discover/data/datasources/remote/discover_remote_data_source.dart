import 'package:flow_zero_waste/src/discover/data/models/banner_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/category_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/offer_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';

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
}
