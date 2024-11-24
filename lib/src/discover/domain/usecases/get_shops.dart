import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

/// GetShops
@singleton
class GetShops extends UseCase<List<Shop>, GetShopsParams> {
  /// Default constructor
  GetShops({required DiscoverRepository repository})
      : _repository = repository;
  final DiscoverRepository _repository;

  @override
  ResultFuture<Failure, List<Shop>> call(GetShopsParams params) {
    return _repository.getShops(
      languageCode: params.languageCode,
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

/// GetShopsParams
class GetShopsParams {
  /// Default constructor
  GetShopsParams({
    required this.languageCode,
    required this.latitude,
    required this.longitude,
  });

  /// Language code
  final String languageCode;

  /// Latitude
  final double latitude;

  /// Longitude
  final double longitude;
}
