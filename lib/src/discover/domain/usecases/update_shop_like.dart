import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

/// UpdateShopLike
@singleton
class UpdateShopLike extends UseCase<void,UpdateShopLikeParams> {
  /// Default constructor
  UpdateShopLike({required DiscoverRepository repository}) : _repository = repository;
  final DiscoverRepository _repository;

  @override
  ResultFuture<Failure, void> call(UpdateShopLikeParams params) {
    return _repository.likeShop(params.shopId);
  }
  
}

/// UpdateShopLikeParams
class UpdateShopLikeParams {
  /// Default constructor
  UpdateShopLikeParams({required this.shopId});
  /// Shop id
  final String shopId;
}
