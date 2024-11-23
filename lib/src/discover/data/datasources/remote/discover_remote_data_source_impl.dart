import 'dart:convert';

import 'package:flow_zero_waste/core/common/data/dev/discover_data_base.dart';
import 'package:flow_zero_waste/src/discover/data/datasources/discover_data_source_exceptions.dart';
import 'package:flow_zero_waste/src/discover/data/datasources/remote/discover_remote_data_source.dart';
import 'package:flow_zero_waste/src/discover/data/models/banner_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/category_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/offer_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';
import 'package:injectable/injectable.dart';

/// DiscoverRemoteDataSourceImpl
@Singleton(as: DiscoverRemoteDataSource)
class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  final _bannerdb = BannerHiveStorage(boxName: bannerBoxName);
  final _categorydb = CategoryHiveStorage(boxName: categoryBoxName);
  final _offerdb = OfferHiveStorage(boxName: offerBoxName);
  final _shopdb = ShopHiveStorage(boxName: shopBoxName);

  @override
  Future<List<BannerModel>> getBanners({required String languageCode}) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final result = await _bannerdb.readAll();
      final banners = result
          .map(
            (jsonData) => BannerModel.fromJson(
                json.decode(jsonData) as Map<String, dynamic>),
          )
          .toList();
      return banners;
    } catch (e, st) {
      throw UnableToGetBannerDataException(
        action: 'getBanners',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<List<CategoryModel>> getCategories(
      {required String languageCode}) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      final result = await _categorydb.readAll();
      final categories = result
          .map(
            (jsonData) => CategoryModel.fromJson(
                json.decode(jsonData) as Map<String, dynamic>),
          )
          .toList();
      return categories;
    } catch (e, st) {
      throw UnableToGetCategoryDataException(
        action: 'getCategories',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<List<OfferModel>> getOffers({
    required double latitude,
    required double longitude,
  }) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      final result = await _offerdb.readAll();
      final offers = result
          .map(
            (jsonData) => OfferModel.fromJson(
                json.decode(jsonData) as Map<String, dynamic>),
          )
          .toList();
      return offers;
    } catch (e, st) {
      throw UnableToGetOfferDataException(
        action: 'getOffers',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<List<ShopModel>> getShops(
      {required double latitude, required double longitude}) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final result = await _shopdb.readAll();
      final shops = result
          .map(
            (jsonData) => ShopModel.fromJson(
                json.decode(jsonData) as Map<String, dynamic>),
          )
          .toList();
      return shops;
    } catch (e, st) {
      throw UnableToGetShopDataException(
        action: 'getShops',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> likeShop(String id) async {
    try {
      final shopData = await _shopdb.read(key: id);
      print(shopData);
      final shopJson = json.decode(shopData!) as Map<String, dynamic>;
      final isLiked = shopJson['isLiked'] as bool? ?? false;
      final newShopJson = shopJson..['isLiked'] = !isLiked;
      print(newShopJson);
      await _shopdb.write(json.encode(newShopJson), key: id);
      return;
    } catch (e, st) {
      throw UnableToLikeShopException(
        action: 'likeShop',
        error: e,
        stackTrace: st,
      );
    }
  }
}
