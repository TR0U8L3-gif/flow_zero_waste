part of 'shop_cubit.dart';

sealed class ShopState extends BaseLogicState with EquatableMixin {
  const ShopState();

  @override
  List<Object> get props => [];
}

final class ShopInitial extends ShopState with BuildableLogicState {}

final class ShopLoading extends ShopState with BuildableLogicState {}

final class ShopIdle extends ShopState with BuildableLogicState {
  const ShopIdle({required this.shop, required this.products});

  final Shop? shop;
  final List<Product> products;

  @override
  List<Object> get props => [shop ?? 'shop', products];
}

final class ShopError extends ShopState with BuildableLogicState {
  const ShopError({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
