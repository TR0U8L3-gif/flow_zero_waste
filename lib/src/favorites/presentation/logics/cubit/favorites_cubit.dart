import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/favorites/domain/usecases/get_favorites.dart';
import 'package:injectable/injectable.dart';

part 'favorites_state.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required GetFavorites fetchFavorites,
  })  : _fetchFavorites = fetchFavorites,
        super(FavoritesInitial());

  final GetFavorites _fetchFavorites;

  List<Shop> _favorites = [];

  void initialize() {
    emitIdle();
  }

  Future<void> fetchFavorites(String languageCode) async {
    emit(const FavoritesLoading(favorites: []));
    final response =
        await _fetchFavorites(GetFavoritesParams(languageCode: languageCode));

    response.fold(
      (failure) {
        emit(FavoritesError(failure: failure));
        emitIdle();
      },
      (favorites) {
        _favorites = favorites;
        emitIdle(favorites: favorites);
      },
    );
  }

  void emitIdle({
    List<Shop>? favorites,
  }) {
    if (isClosed) return;
    emit(FavoritesIdle(favorites: List.from(favorites ?? _favorites)));
  }
}
