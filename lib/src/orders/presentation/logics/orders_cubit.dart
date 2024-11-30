import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/orders.dart';
import 'package:flow_zero_waste/src/orders/domain/usecases/cancel_order.dart';
import 'package:flow_zero_waste/src/orders/domain/usecases/get_orders.dart';
import 'package:injectable/injectable.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required GetOrders getOrders,
    required CancelOrder cancelOrder,
  })  : _getOrders = getOrders,
        _cancelOrder = cancelOrder,
        super(OrdersInitial());

  final GetOrders _getOrders;
  final CancelOrder _cancelOrder;

  Future<void> fetchOrders(String languageCode) async {
    emit(OrdersLoading());
    final result =
        await _getOrders(GetOrdersParams(languageCode: languageCode));
    result.fold(
      (failure) => emit(OrdersError(failure: failure)),
      (orders) => emit(OrdersIdle(orders: orders)),
    );
  }

  Future<void> cancelOrder(String orderId, String languageCode) async {
    emit(OrdersLoading());
    final result = await _cancelOrder(CancelOrderParams(orderId: orderId));
    result.fold(
      (failure) => emit(OrdersError(failure: failure)),
      (success) => fetchOrders(languageCode),
    );
  }
}
