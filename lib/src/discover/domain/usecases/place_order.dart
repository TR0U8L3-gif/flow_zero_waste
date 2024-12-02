import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class PlaceOrder extends UseCase<void, PlaceOrderParams> {
  PlaceOrder({required DiscoverRepository repository})
      : _repository = repository;
  final DiscoverRepository _repository;

  @override
  ResultFuture<Failure, void> call(PlaceOrderParams params) {
    return _repository.placeOrder(
      shopId: params.shopId,
      productId: params.productId,
      quantity: params.quantity,
      languageCode: params.languageCode,
    );
  }
}

class PlaceOrderParams {
  final String shopId;
  final String productId;
  final int quantity;
  final String languageCode;

  PlaceOrderParams({
    required this.shopId,
    required this.productId,
    required this.quantity,
    required this.languageCode,
  });
}
