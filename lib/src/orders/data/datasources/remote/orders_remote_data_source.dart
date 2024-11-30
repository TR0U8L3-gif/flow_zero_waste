import 'dart:convert';

import 'package:flow_zero_waste/core/common/data/dev/flow_data_base.dart';
import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';
import 'package:flow_zero_waste/src/orders/data/models/orders_model.dart';
import 'package:flow_zero_waste/src/orders/data/models/product_model.dart';
import 'package:injectable/injectable.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrdersModel>> getOrders(String languageCode);
  Future<ProductModel> getProduct(String id);
  Future<ShopModel> getShop(String id);
  Future<void> cancelOrder(String id);
}

@Singleton(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final _ordersdb = OrdersHiveStorage();
  final _productdb = ProductsHiveStorage();
  final _shopdb = ShopHiveStorage();

  @override
  Future<void> cancelOrder(String id) async {
    try{
      final orderData = await _ordersdb.read(key: id);
      final modifiedOrder = json.decode(orderData!) as Map<String, dynamic>;
      modifiedOrder['status'] = -1;
      await _ordersdb.write(key: id, json.encode(modifiedOrder));
      return;
    } catch(e){
      rethrow;
    }
  }

  @override
  Future<List<OrdersModel>> getOrders(String languageCode) async {
    try {
      final ordersData = await _ordersdb.readAll();
      final orderList = <OrdersModel>[];

      for (final orders in ordersData) {
        final shopData = json.decode(orders) as Map<String, dynamic>;
        if (shopData['languageCode'] == languageCode) {
          orderList.add(OrdersModel.fromJson(shopData));
        }
      }

      return orderList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    try {
      final productData = await _productdb.read(key: id);
      return ProductModel.fromJson(
        json.decode(productData!) as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ShopModel> getShop(String id) async {
    try {
      final shopData = await _shopdb.read(key: id);
      return ShopModel.fromJson(json.decode(shopData!) as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
