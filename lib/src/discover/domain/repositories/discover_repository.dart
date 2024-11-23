import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/banner.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/category.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/offer.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';

/// discover repository
abstract class DiscoverRepository {
  /// get banners
  ResultFuture<Failure, List<Banner>> getBanners({
    required String languageCode,
  });

  /// get shops
  ResultFuture<Failure, List<Shop>> getShops({
    required double latitude,
    required double longitude,
  });

  /// get categories
  ResultFuture<Failure, List<Category>> getCategories({
    required String languageCode,
  });

  /// get offers
  ResultFuture<Failure, List<Offer>> getOffers({
    required double latitude,
    required double longitude,
  });

  /// get recommended shops
  ResultFuture<Failure, void> likeShop(String id);
}
