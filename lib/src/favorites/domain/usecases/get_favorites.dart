import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/favorites/domain/repositories/favorites_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetFavorites extends UseCase<List<Shop>,GetFavoritesParams> {
  GetFavorites({required FavoritesRepository repository}) : _repository = repository;
  final FavoritesRepository _repository;

  @override
  ResultFuture<Failure, List<Shop>> call(GetFavoritesParams params) {
    return _repository.getFavorites(params.languageCode);
  }
  
}

class GetFavoritesParams {
  GetFavoritesParams({required this.languageCode});
  final String languageCode;
}
