part of 'shops_cubit.dart';

sealed class ShopsState extends BaseLogicState with EquatableMixin {
  const ShopsState();

  @override
  List<Object> get props => [];
}

final class ShopsInitial extends ShopsState with BuildableLogicState {}

final class ShopsIdle extends ShopsState with BuildableLogicState {
  const ShopsIdle({required this.shops});

  final List<Shop> shops;

  @override
  List<Object> get props => [shops];
}

final class ShopsLoading extends ShopsState with BuildableLogicState {}

final class ShopsError extends ShopsState with BuildableLogicState {
  const ShopsError({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
