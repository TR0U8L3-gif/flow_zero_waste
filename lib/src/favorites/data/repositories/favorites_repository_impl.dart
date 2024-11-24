import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/shop_mapper.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/favorites/data/datasources/favorites_exception.dart';
import 'package:flow_zero_waste/src/favorites/data/datasources/remote/favorites_remote_data_source.dart';
import 'package:flow_zero_waste/src/favorites/domain/repositories/favorites_repository.dart';
import 'package:flow_zero_waste/src/favorites/domain/response/favorites_response.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

@Singleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl({
    required LoggerManager logger,
    required ShopMapper shopMapper,
    required FavoritesRemoteDataSource remoteDataSource,
  })  : _logger = logger,
        _shopMapper = shopMapper,
        _remoteDataSource = remoteDataSource;

  final LoggerManager _logger;
  final ShopMapper _shopMapper;
  final FavoritesRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<Failure, List<Shop>> getFavorites(String languageCode) async {
    try {
      _logger.info(message: 'Fetching favorites');
      final favorites = await _remoteDataSource.getFavorites(languageCode);
      _logger.info(message: 'Favorites fetched');
      return Right(favorites.map(_shopMapper.from).toList());
    } on GetFavoritesException catch (e, st) {
      _logger.error(
        message: 'GetFavoritesException get favorites',
        error: e,
        stackTrace: st,
      );
      return const Left(GetFavoritesFailure());
    } catch (e, st) {
      _logger.fatal(
        message: 'get favorites',
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: 'Unknown error'));
    }
  }
}
