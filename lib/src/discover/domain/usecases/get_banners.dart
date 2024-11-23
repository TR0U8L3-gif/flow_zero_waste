import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/banner.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';
/// GetBanners
@singleton
class GetBanners extends UseCase<List<Banner>, GetBannersParams> {
  /// Default constructor
  GetBanners({required DiscoverRepository repository})
      : _repository = repository;
  final DiscoverRepository _repository;

  @override
  ResultFuture<Failure, List<Banner>> call(GetBannersParams params) {
    return _repository.getBanners(languageCode: params.languageCode);
  }
}

/// GetBannersParams
class GetBannersParams {
  /// Default constructor
  GetBannersParams({required this.languageCode});

  /// Language code
  final String languageCode;
}
