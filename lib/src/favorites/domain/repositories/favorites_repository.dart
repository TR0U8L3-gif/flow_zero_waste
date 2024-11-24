import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';

abstract class FavoritesRepository {
  ResultFuture<Failure, List<Shop>> getFavorites(String languageCode);
}