import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/orders.dart';

abstract class OrdersRepository {
  ResultFuture<Failure, List<Orders>> getOrders(String languageCode);
  ResultFuture<Failure, void> cancelOrder(String orderId);
}
