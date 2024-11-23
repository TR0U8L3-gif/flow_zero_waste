part of 'discover_cubit.dart';

/// DiscoverState
sealed class DiscoverState extends BaseLogicState with EquatableMixin {
  const DiscoverState();
}

/// DiscoverInitial
final class DiscoverInitial extends DiscoverState with BuildableLogicState {
  /// Default constructor
  const DiscoverInitial();
  @override
  List<Object?> get props => [];
}

/// DiscoverDataState
abstract class DiscoverDataState extends DiscoverState {
  /// Default constructor
  const DiscoverDataState({
    required this.banners,
    required this.categories,
    required this.offers,
    required this.shops,
  });

  /// Banners
  final List<Banner> banners;
  /// Categories
  final List<Category> categories;
  /// Offers
  final List<Offer> offers;
  /// Shops
  final List<Shop> shops;
}

/// DiscoverLoading
final class DiscoverLoading extends DiscoverDataState with BuildableLogicState {
  /// Default constructor
  DiscoverLoading({
    required super.banners,
    required super.categories,
    required super.offers,
    required super.shops,
  });

  @override
  List<Object?> get props => [
    super.banners,
    super.categories,
    super.offers,
    super.shops,
  ];
}

/// DiscoverIdle
final class DiscoverIdle extends DiscoverDataState with BuildableLogicState {
  /// Default constructor
  DiscoverIdle({
    required super.banners,
    required super.categories,
    required super.offers,
    required super.shops,
  });

  @override
  List<Object?> get props => [
    super.banners,
    super.categories,
    super.offers,
    super.shops,
  ];
}

/// DiscoverError
final class DiscoverError extends DiscoverState with ListenableLogicState {
  /// Default constructor
  DiscoverError({
    required this.failure,
  });

  /// Message
  final Failure failure;

  @override
  List<Object?> get props => [
    failure,
  ];
}

/// DiscoverChooseLocation
final class DiscoverChooseLocation extends DiscoverState with BuildableLogicState {
  /// Default constructor
  const DiscoverChooseLocation();
  @override
  List<Object?> get props => [];
}
