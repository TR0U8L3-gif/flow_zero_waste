import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/banner.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/category.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/offer.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/product.dart';

/// discover repository
abstract class DiscoverRepository {
  /// get banners
  ResultFuture<Failure, List<Banner>> getBanners({
    required String languageCode,
  });

  /// get shops
  ResultFuture<Failure, List<Shop>> getShops({
    required String languageCode,
    required double latitude,
    required double longitude,
  });

  /// get categories
  ResultFuture<Failure, List<Category>> getCategories({
    required String languageCode,
  });

  /// get offers
  ResultFuture<Failure, List<Offer>> getOffers({
    required String languageCode,
    required double latitude,
    required double longitude,
  });

  /// get recommended shops
  ResultFuture<Failure, void> likeShop(String id);

  /// get shop wih products
  ResultFuture<Failure, (Shop, List<Product>)> getShopWithProducts({
    required String languageCode,
    required String shopId,
  });

  /// place order
  ResultFuture<Failure, void> placeOrder({
    required String shopId,
    required String productId,
    required int quantity,
    required String languageCode,
  });
}
