import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/orders.dart';
import 'package:flow_zero_waste/src/orders/domain/repositories/orders_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetOrders extends UseCase<List<Orders>,GetOrdersParams> {
  GetOrders({required OrdersRepository repository}) : _repository = repository;
  final OrdersRepository _repository;

  @override
  ResultFuture<Failure, List<Orders>> call(GetOrdersParams params) {
    return _repository.getOrders(params.languageCode);
  }
  
}

class GetOrdersParams {
  GetOrdersParams({required this.languageCode});
  final String languageCode;
}
