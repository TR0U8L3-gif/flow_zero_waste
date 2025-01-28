import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/orders/data/models/orders_model.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/orders.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/product.dart';
import 'package:injectable/injectable.dart';

@singleton
class OrdersMapper extends Mapper<OrdersModel, Orders> {
  @override
  Orders from(
    OrdersModel object, {
    Shop? shop,
    List<Product>? products,
  }) {
    if (shop == null || products == null) {
      throw Exception('Shop or Order is null');
    }

    return Orders(
      id: object.id,
      code: object.code,
      date: DateTime.parse(object.date),
      status: _getStatus(object.status),
      products: products,
      shop: shop,
    );
  }

  @override
  OrdersModel to(
    Orders object, {
    String? shopId,
    List<String>? productIds,
  }) {
    if (shopId == null || productIds == null) {
      throw Exception('Shop or Order is null');
    }
    return OrdersModel(
      id: object.id,
      code: object.code,
      date: object.date.toUtc().toIso8601String(),
      status: _getStatusValue(object.status),
      productIds: productIds,
      shopId: shopId,
    );
  }

  OrderStatus _getStatus(int status) {
    switch (status) {
      case 0:
        return OrderStatus.accepted;
      case 1:
        return OrderStatus.completed;
      case -1:
        return OrderStatus.canceled;
      default:
        return OrderStatus.pending;
    }
  }

  int _getStatusValue(OrderStatus status) {
    switch (status) {
      case OrderStatus.accepted:
        return 0;
      case OrderStatus.completed:
        return 1;
      case OrderStatus.canceled:
        return -1;
      default:
        return 2;
    }
  }
}
