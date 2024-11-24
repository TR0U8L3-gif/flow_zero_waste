import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<ShopModel>> getFavorites(String languageCode);
}
