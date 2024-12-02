import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/product.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetShopWithProducts
    extends UseCase<(Shop, List<Product>), GetShopWithProductsParams> {
  GetShopWithProducts({required DiscoverRepository repository})
      : _repository = repository;
  final DiscoverRepository _repository;

  @override
  ResultFuture<Failure, (Shop, List<Product>)> call(GetShopWithProductsParams params) {
    return _repository.getShopWithProducts(
      languageCode: params.languageCode,
      shopId: params.shopId,
    );
  }
}

class GetShopWithProductsParams {
  GetShopWithProductsParams({
    required this.languageCode,
    required this.shopId,
  });

  final String languageCode;
  final String shopId;
}
