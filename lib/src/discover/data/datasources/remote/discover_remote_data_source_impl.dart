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
  final _bannerdb = BannerHiveStorage();
  final _categorydb = CategoryHiveStorage();
  final _offerdb = OfferHiveStorage();
  final _shopdb = ShopHiveStorage();

  @override
  Future<List<BannerModel>> getBanners({required String languageCode}) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final result = await _bannerdb.readAll();

      final banners = <BannerModel>[];

      for (final data in result) {
        final jsonData = json.decode(data) as Map<String, dynamic>;

        if (jsonData['languageCode'] != languageCode) {
          continue;
        }

        final banner = BannerModel.fromJson(
          jsonData,
        );
        banners.add(banner);
      }

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
  Future<List<CategoryModel>> getCategories({
    required String languageCode,
  }) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      final result = await _categorydb.readAll();

      final categories = <CategoryModel>[];

      for (final data in result) {
        final jsonData = json.decode(data) as Map<String, dynamic>;

        if (jsonData['languageCode'] != languageCode) {
          continue;
        }

        final category = CategoryModel.fromJson(
          jsonData,
        );
        categories.add(category);
      }

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
    required String languageCode,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      final result = await _offerdb.readAll();

      final offers = <OfferModel>[];

      for (final data in result) {
        final jsonData = json.decode(data) as Map<String, dynamic>;

        if (jsonData['languageCode'] != languageCode) {
          continue;
        }

        final offer = OfferModel.fromJson(
          jsonData,
        );
        offers.add(offer);
      }

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
  Future<List<ShopModel>> getShops({
    required String languageCode,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final result = await _shopdb.readAll();

      final shops = <ShopModel>[];

      for (final data in result) {
        final jsonData = json.decode(data) as Map<String, dynamic>;

        if (jsonData['languageCode'] != languageCode) {
          continue;
        }

        final shop = ShopModel.fromJson(
          jsonData,
        );
        shops.add(shop);
      }

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
      final ids = <String>[];

      if (id.length >= 3 && id.substring(id.length - 3) == '-pl') {
        ids
          ..add(id)
          ..add(id.substring(0, id.length - 3));
      } else {
        ids
          ..add(id)
          ..add('$id-pl');
      }

      for (final id in ids) {
        final shopData = await _shopdb.read(key: id);
        final shopJson = json.decode(shopData!) as Map<String, dynamic>;
        final isLiked = shopJson['isLiked'] as bool? ?? false;
        final newShopJson = shopJson..['isLiked'] = !isLiked;
        await _shopdb.write(json.encode(newShopJson), key: id);
      }

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
