import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/data/datasources/discover_data_source_exceptions.dart';
import 'package:flow_zero_waste/src/discover/data/datasources/remote/discover_remote_data_source.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/banner_mapper.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/category_mapper.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/offer_mapper.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/shop_mapper.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/banner.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/category.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/offer.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:flow_zero_waste/src/discover/domain/responses/discover_responses.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

/// DiscoverRepositoryImpl
@Singleton(as: DiscoverRepository)
class DiscoverRepositoryImpl implements DiscoverRepository {
  /// Default constructor
  const DiscoverRepositoryImpl({
    required LoggerManager loggerManager,
    required DiscoverRemoteDataSource discoverRemoteDataSource,
    required BannerMapper bannerMapper,
    required CategoryMapper categoryMapper,
    required OfferMapper offerMapper,
    required ShopMapper shopMapper,
  })  : _logger = loggerManager,
        _discoverRemoteDataSource = discoverRemoteDataSource,
        _bannerMapper = bannerMapper,
        _categoryMapper = categoryMapper,
        _offerMapper = offerMapper,
        _shopMapper = shopMapper;

  final LoggerManager _logger;
  final DiscoverRemoteDataSource _discoverRemoteDataSource;
  final BannerMapper _bannerMapper;
  final CategoryMapper _categoryMapper;
  final OfferMapper _offerMapper;
  final ShopMapper _shopMapper;

  @override
  ResultFuture<Failure, List<Banner>> getBanners({
    required String languageCode,
  }) async {
    _logger.trace(message: 'getting Banners');
    try {
      final result = await _discoverRemoteDataSource.getBanners(
        languageCode: languageCode,
      );
      final banners = result.map(_bannerMapper.from).toList();
      _logger.trace(message: 'received banners: ${banners.length}');
      return Right(banners);
    } on UnableToGetBannerDataException catch (e, st) {
      _logger.error(message: 'Unable to get Banners', error: e, stackTrace: st);
      return const Left(UnableToGetBannerDataFailure());
    } catch (e, st) {
      _logger.fatal(message: 'Unable to get Banners', error: e, stackTrace: st);
      return const Left(Failure(message: 'Unable to get Banners'));
    }
  }

  @override
  ResultFuture<Failure, List<Category>> getCategories({
    required String languageCode,
  }) async {
    _logger.trace(message: 'getting Categories');
    try {
      final result = await _discoverRemoteDataSource.getCategories(
        languageCode: languageCode,
      );
      final categories = result.map(_categoryMapper.from).toList();
      _logger.trace(message: 'received categories: ${categories.length}');

      return Right(categories);
    } on UnableToGetCategoryDataException catch (e, st) {
      _logger.error(
        message: 'Unable to get Categories',
        error: e,
        stackTrace: st,
      );
      return const Left(UnableToGetCategoryDataFailure());
    } catch (e, st) {
      _logger.fatal(
        message: 'Unable to get Categories',
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: 'Unable to get Categories'));
    }
  }

  @override
  ResultFuture<Failure, List<Offer>> getOffers({
    required String languageCode,
    required double latitude,
    required double longitude,
  }) async {
    _logger.trace(message: 'getting Offers');
    try {
      final result = await _discoverRemoteDataSource.getOffers(
        languageCode: languageCode,
        latitude: latitude,
        longitude: longitude,
      );
      final offers = result.map(_offerMapper.from).toList();
      _logger.trace(message: 'received offers: ${offers.length}');
      return Right(offers);
    } on UnableToGetOfferDataException catch (e, st) {
      _logger.error(message: 'Unable to get Offers', error: e, stackTrace: st);
      return const Left(UnableToGetOfferDataFailure());
    } catch (e, st) {
      _logger.fatal(message: 'Unable to get Offers', error: e, stackTrace: st);
      return const Left(Failure(message: 'Unable to get Offers'));
    }
  }

  @override
  ResultFuture<Failure, List<Shop>> getShops({
    required String languageCode,
    required double latitude,
    required double longitude,
  }) async {
    _logger.trace(message: 'getting Shops');
    try {
      final result = await _discoverRemoteDataSource.getShops(
        languageCode: languageCode,
        latitude: latitude,
        longitude: longitude,
      );
      final shops = result.map(_shopMapper.from).toList();
      _logger.trace(message: 'received shops: ${shops.length}');
      return Right(shops);
    } on UnableToGetShopDataException catch (e, st) {
      _logger.error(message: 'Unable to get Shops', error: e, stackTrace: st);
      return const Left(UnableToLikeShopFailure());
    } catch (e, st) {
      _logger.fatal(message: 'Unable to get Shops', error: e, stackTrace: st);
      return const Left(Failure(message: 'Unable to get Shops'));
    }
  }

  @override
  ResultFuture<Failure, void> likeShop(String id) async {
    _logger.trace(message: 'liking Shop');
    try {
      await _discoverRemoteDataSource.likeShop(id);
      _logger.trace(message: 'liked Shop');
      return const Right(null);
    } on UnableToLikeShopException catch (e, st) {
      _logger.error(message: 'Unable to like Shop', error: e, stackTrace: st);
      return const Left(UnableToLikeShopFailure());
    } catch (e, st) {
      _logger.fatal(message: 'Unable to like Shop', error: e, stackTrace: st);
      return const Left(Failure(message: 'Unable to like Shop'));
    }
  }
}
