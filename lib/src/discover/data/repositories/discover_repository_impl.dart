import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/data/datasources/remote/discover_remote_data_source.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/banner_mapper.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/category_mapper.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/offer_mapper.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/shop_mapper.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/offer.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:flutter/src/foundation/annotations.dart';
import 'package:flutter/src/widgets/banner.dart';
import 'package:logger_manager/logger_manager.dart';

/// DiscoverRepositoryImpl
class DiscoverRepositoryImpl implements DiscoverRepository {
  /// Default constructor
  const DiscoverRepositoryImpl({
    required LoggerManager loggerManager,
    required DiscoverRemoteDataSource discoverRemoteDataSource,
    required BannerMapper bannerMapper,
    required CategoryMapper categoryMapper,
    required OfferMapper offerMapper,
    required ShopMapper shopMapper,
  })  : _loggerManager = loggerManager,
        _discoverRemoteDataSource = discoverRemoteDataSource,
        _bannerMapper = bannerMapper,
        _categoryMapper = categoryMapper,
        _offerMapper = offerMapper,
        _shopMapper = shopMapper;

  final LoggerManager _loggerManager;
  final DiscoverRemoteDataSource _discoverRemoteDataSource;
  final BannerMapper _bannerMapper;
  final CategoryMapper _categoryMapper;
  final OfferMapper _offerMapper;
  final ShopMapper _shopMapper;

  @override
  ResultFuture<Failure, List<Banner>> getBanners({
    required String languageCode,
  }) {
    // TODO: implement getBanners
    throw UnimplementedError();
  }

  @override
  ResultFuture<Failure, List<Category>> getCategories({
    required String languageCode,
  }) {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  ResultFuture<Failure, List<Offer>> getOffers({
    required double latitude,
    required double longitude,
  }) {
    // TODO: implement getOffers
    throw UnimplementedError();
  }

  @override
  ResultFuture<Failure, List<Shop>> getShops({
    required double latitude,
    required double longitude,
  }) {
    // TODO: implement getShops
    throw UnimplementedError();
  }

  @override
  ResultFuture<Failure, void> likeShop(String id) {
    // TODO: implement likeShop
    throw UnimplementedError();
  }
}
