import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/shop_mapper.dart';
import 'package:flow_zero_waste/src/orders/data/datasources/remote/orders_remote_data_source.dart';
import 'package:flow_zero_waste/src/orders/data/mappers/orders_mapper.dart';
import 'package:flow_zero_waste/src/orders/data/mappers/product_mapper.dart';
import 'package:flow_zero_waste/src/orders/data/models/product_model.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/orders.dart';
import 'package:flow_zero_waste/src/orders/domain/repositories/orders_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

@Singleton(as: OrdersRepository)
class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl({
    required LoggerManager logger,
    required ShopMapper shopMapper,
    required ProductMapper productMapper,
    required OrdersMapper ordersMapper,
    required OrdersRemoteDataSource ordersRemoteDataSource,
  })  : _logger = logger,
        _shopMapper = shopMapper,
        _productMapper = productMapper,
        _ordersMapper = ordersMapper,
        _ordersRemoteDataSource = ordersRemoteDataSource;

  final LoggerManager _logger;
  final ShopMapper _shopMapper;
  final ProductMapper _productMapper;
  final OrdersMapper _ordersMapper;
  final OrdersRemoteDataSource _ordersRemoteDataSource;

  @override
  ResultFuture<Failure, void> cancelOrder(String orderId) async {
    try {
      await _ordersRemoteDataSource.cancelOrder(orderId);
      return const Right(null);
    } catch (e, st) {
      _logger.error(
        message: 'Error cancelling order',
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: 'Error cancelling order'));
    }
  }

  @override
  ResultFuture<Failure, List<Orders>> getOrders(String languageCode) async {
    try {
      final orders = await _ordersRemoteDataSource.getOrders(languageCode);
      final orderList = <Orders>[];
      for (final orderModel in orders) {
        try {
          final shopModel =
              await _ordersRemoteDataSource.getShop(orderModel.shopId);

          List<ProductModel> productModels = [];

          for (final productId in orderModel.productIds) {
            final productModel =
                await _ordersRemoteDataSource.getProduct(productId);
            productModels.add(productModel);
          }

          final shop = _shopMapper.from(shopModel);

          final order = _ordersMapper.from(
            orderModel,
            shop: shop,
            products: productModels.map(_productMapper.from).toList(),
          );
          orderList.add(order);
        } catch (e) {
          continue;
        }
      }
      return Right(orderList);
    } catch (e, st) {
      _logger.error(message: 'Error fetching orders', error: e, stackTrace: st);
      return const Left(Failure(message: 'Error fetching orders'));
    }
  }
}
