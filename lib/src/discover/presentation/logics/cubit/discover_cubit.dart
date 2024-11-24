import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/banner.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/category.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/offer.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/get_banners.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/get_categories.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/get_offers.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/get_shops.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/update_shop_like.dart';
import 'package:injectable/injectable.dart';

part 'discover_state.dart';

/// DiscoverCubit
@injectable
class DiscoverCubit extends Cubit<DiscoverState> {
  /// Default constructor
  DiscoverCubit({
    required UpdateShopLike updateShopLike,
    required GetBanners getBanners,
    required GetCategories getCategories,
    required GetOffers getOffers,
    required GetShops getShops,
  })  : _updateShopLike = updateShopLike,
        _getBanners = getBanners,
        _getCategories = getCategories,
        _getOffers = getOffers,
        _getShops = getShops,
        super(const DiscoverInitial());

  final UpdateShopLike _updateShopLike;

  final GetBanners _getBanners;
  final GetCategories _getCategories;
  final GetOffers _getOffers;
  final GetShops _getShops;

  List<Banner> _banners = [];
  List<Category> _categories = [];
  List<Offer> _offers = [];
  List<Shop> _shops = [];

  /// Initialize cubit
  void initialize() {
    emit(
      DiscoverLoading(
        banners: const [],
        categories: const [],
        offers: const [],
        shops: const [],
      ),
    );
  }

  /// get discover data
  Future<void> getDiscoverData({
    required String languageCode,
    required double? latitude,
    required double? longitude,
  }) async {
    if (latitude == null || longitude == null) {
      emit(const DiscoverChooseLocation());
      return;
    }
    emit(
      DiscoverLoading(
        banners: const [],
        categories: const [],
        offers: const [],
        shops: const [],
      ),
    );

    final bannersResult = await _getBanners(
      GetBannersParams(
        languageCode: languageCode,
      ),
    );

    bannersResult.fold(
      (failure) {
        _emitIdle();
      },
      (banners) {
        _banners = banners;
        emit(
          DiscoverLoading(
            banners: _banners,
            categories: const [],
            offers: const [],
            shops: const [],
          ),
        );
      },
    );

    final categoriesResult = await _getCategories(
      GetCategoriesParams(
        languageCode: languageCode,
      ),
    );

    categoriesResult.fold(
      (failure) {
        _emitIdle();
      },
      (categories) {
        _categories = categories;
        emit(
          DiscoverLoading(
            banners: _banners,
            categories: _categories,
            offers: const [],
            shops: const [],
          ),
        );
      },
    );

    final offersResult = await _getOffers(
      GetOffersParams(
        latitude: latitude,
        longitude: longitude,
        languageCode: languageCode,
      ),
    );

    offersResult.fold(
      (failure) {
        _emitIdle();
      },
      (offers) {
        _offers = offers;
        emit(
          DiscoverLoading(
            banners: _banners,
            categories: _categories,
            offers: _offers,
            shops: const [],
          ),
        );
      },
    );

    final shopsResult = await _getShops(
      GetShopsParams(
        latitude: latitude,
        longitude: longitude,
        languageCode: languageCode,
      ),
    );

    shopsResult.fold(
      (failure) {
        _emitIdle();
      },
      (shops) {
        _shops = shops;
        emit(
          DiscoverIdle(
            banners: _banners,
            categories: _categories,
            offers: _offers,
            shops: _shops,
          ),
        );
      },
    );

    _emitIdle();
  }

  /// like shop
  Future<void> likeShop(String id) async {
    final result = await _updateShopLike.call(UpdateShopLikeParams(shopId: id));
    result.fold(
      (failure) {
        emit(
          DiscoverError(
            failure: failure,
          ),
        );
        _emitIdle();
      },
      (_) {
        final updatedShops = _shops.map((shop) {
          if (shop.id == id) {
            return shop.copyWith(isLiked: !shop.isLiked);
          }
          return shop;
        }).toList();

        final updatedOffers = _offers.map((offer) {
          if (offer.shop.id == id) {
            return offer.copyWith(
              shop: offer.shop.copyWith(isLiked: !offer.shop.isLiked),
            );
          }
          return offer;
        }).toList();
        _offers = updatedOffers;
        _shops = updatedShops;
        _emitIdle(shops: updatedShops, offers: updatedOffers);
      },
    );
  }

  /// clear discover data
  void clearDiscoverData() {
    _banners = [];
    _categories = [];
    _offers = [];
    _shops = [];
  }

  void _emitIdle({
    List<Banner>? banners,
    List<Category>? categories,
    List<Offer>? offers,
    List<Shop>? shops,
  }) {
    emit(
      DiscoverIdle(
        banners: List.from(banners ?? _banners),
        categories: List.from(categories ?? _categories),
        offers: List.from(offers ?? _offers),
        shops: List.from(shops ?? _shops),
      ),
    );
  }
}
