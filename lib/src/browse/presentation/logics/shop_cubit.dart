import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/get_shop_with_products.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/place_order.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/update_shop_like.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/product.dart';
import 'package:injectable/injectable.dart';

part 'shop_state.dart';

@injectable
class ShopCubit extends Cubit<ShopState> {
  ShopCubit({
    required GetShopWithProducts getShopWithProducts,
    required UpdateShopLike updateShopLike,
    required PlaceOrder placeOrder,
  })  : _getShopWithProducts = getShopWithProducts,
        _updateShopLike = updateShopLike,
        _placeOrder = placeOrder,
        super(ShopInitial());

  final GetShopWithProducts _getShopWithProducts;
  final UpdateShopLike _updateShopLike;
  final PlaceOrder _placeOrder;

  Shop? _shop;
  List<Product> _products = [];

  Future<void> getShop(String id, String languageCode) async {
    emit(ShopLoading());
    final result = await _getShopWithProducts(
      GetShopWithProductsParams(languageCode: languageCode, shopId: id),
    );
    result.fold((failure) => emit(ShopError(failure: failure)), (data) {
      _shop = data.$1;
      _products = data.$2;
    });
    emit(ShopIdle(shop: _shop, products: _products));
  }

  Future<void> order(Product product, String languageCode) async {
    if (_shop == null) {
      return;
    }
    final result = await _placeOrder(
      PlaceOrderParams(
        shopId: _shop!.id,
        productId: product.id,
        quantity: product.quantity,
        languageCode: languageCode,
      ),
    );

    result.fold(
      (failure) => failure,
      (data) => getShop(_shop!.id, languageCode),
    );
  }

  Future<void> like(String languageCode) async {
    if (_shop == null) {
      return;
    }
    final result = await _updateShopLike(
      UpdateShopLikeParams(
        shopId: _shop!.id,
      ),
    );
    result.fold((failure) => emit(ShopError(failure: failure)), (data) async {
      emit(ShopLoading());
      final result = await _getShopWithProducts(
        GetShopWithProductsParams(
            languageCode: languageCode, shopId: _shop!.id,),
      );
      result.fold((failure) => emit(ShopError(failure: failure)), (data) {
        _shop = data.$1;
      });
      emit(ShopIdle(shop: _shop, products: _products));
    });
  }
}
