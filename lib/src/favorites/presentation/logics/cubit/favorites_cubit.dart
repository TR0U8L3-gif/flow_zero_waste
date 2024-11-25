import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/update_shop_like.dart';
import 'package:flow_zero_waste/src/favorites/domain/usecases/get_favorites.dart';
import 'package:injectable/injectable.dart';

part 'favorites_state.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required GetFavorites fetchFavorites,
    required UpdateShopLike updateShopLike,
  })  : _fetchFavorites = fetchFavorites,
        _updateShopLike = updateShopLike,
        super(const FavoritesInitial());

  final GetFavorites _fetchFavorites;
  final UpdateShopLike _updateShopLike;

  List<Shop>? _favorites = [];

  void initialize() {
    _emitIdle();
  }

  Future<void> fetchFavorites(String languageCode) async {
    emit(const FavoritesLoading(favorites: []));
    final response =
        await _fetchFavorites(GetFavoritesParams(languageCode: languageCode));

    response.fold(
      (failure) {
        emit(FavoritesError(failure: failure));
        _emitIdle();
      },
      (favorites) {
        _favorites = favorites.isEmpty ? null : favorites;
        _emitIdle();
      },
    );
  }

  /// like shop
  Future<void> likeShop(String id) async {
    final result = await _updateShopLike.call(UpdateShopLikeParams(shopId: id));
    result.fold(
      (failure) {
        emit(
          FavoritesError(
            failure: failure,
          ),
        );
        _emitIdle(favorites: []);
      },
      (_) {
        final updatedFavorites = List<Shop>.from(_favorites ?? [])
          ..removeWhere((element) => element.id == id);
        _favorites = updatedFavorites.isEmpty ? null : updatedFavorites;
        _emitIdle();
      },
    );
  }

  void _emitIdle({
    List<Shop>? favorites,
  }) {
    if (isClosed) return;
    emit(FavoritesIdle(favorites: favorites ?? _favorites));
  }
}
