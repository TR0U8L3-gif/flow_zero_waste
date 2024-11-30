import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/orders/domain/repositories/orders_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class CancelOrder extends UseCase<void,CancelOrderParams> {
  CancelOrder({required OrdersRepository repository}) : _repository = repository;
  final OrdersRepository _repository;

  @override
  ResultFuture<Failure, void> call(CancelOrderParams params) {
    return _repository.cancelOrder(params.orderId);
  }
  
}

class CancelOrderParams {
  CancelOrderParams({required this.orderId});
  final String orderId;
}