part of 'favorites_cubit.dart';

sealed class FavoritesState extends BaseLogicState with EquatableMixin {
  const FavoritesState();
}

final class FavoritesInitial extends FavoritesState with BuildableLogicState{
  const FavoritesInitial();
  @override
  List<Object?> get props => [];
}

abstract class FavoritesDataState extends FavoritesState {
  const FavoritesDataState({
    required this.favorites,
  });
  final List<Shop> favorites;
}

final class FavoritesLoading extends FavoritesDataState with BuildableLogicState{
  const FavoritesLoading({
    required List<Shop> favorites,
  }) : super(favorites: favorites);
  @override
  List<Object?> get props => [favorites];
}
final class FavoritesIdle extends FavoritesDataState with BuildableLogicState{
  const FavoritesIdle({
    required List<Shop> favorites,
  }) : super(favorites: favorites);
  @override
  List<Object?> get props => [favorites];
}
final class FavoritesError extends FavoritesState with ListenableLogicState{
  const FavoritesError({
    required this.failure,
  });
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

