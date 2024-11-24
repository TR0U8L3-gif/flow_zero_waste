import 'dart:convert';
import 'dart:math';

import 'package:flow_zero_waste/core/common/data/dev/discover_data_base.dart';
import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';
import 'package:flow_zero_waste/src/favorites/data/datasources/favorites_exception.dart';
import 'package:flow_zero_waste/src/favorites/data/datasources/remote/favorites_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: FavoritesRemoteDataSource)
class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final _shopdb = ShopHiveStorage();

  @override
  Future<List<ShopModel>> getFavorites(String languageCode) async {
    final number = Random().nextInt(5);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (number >= 3) {
      throw GetFavoritesException(
        action: 'getFavorites',
        error: 'Error fetching favorites',
        stackTrace: StackTrace.current,
      );
    }

    final result = await _shopdb.readAll();
    final favorites = <ShopModel>[];

    for (final shop in result) {
      final shopData = json.decode(shop) as Map<String, dynamic>;
      if (shopData['isLiked'] == true &&
          shopData['languageCode'] == languageCode) {
        favorites.add(ShopModel.fromJson(shopData));
      }
    }

    return favorites;
  }
}
