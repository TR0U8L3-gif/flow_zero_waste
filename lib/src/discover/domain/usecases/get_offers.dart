import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/offer.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

/// GetOffers
@singleton
class GetOffers extends UseCase<List<Offer>, GetOffersParams> {
  /// Default constructor
  GetOffers({required DiscoverRepository repository})
      : _repository = repository;
  final DiscoverRepository _repository;

  @override
  ResultFuture<Failure, List<Offer>> call(GetOffersParams params) {
    return _repository.getOffers(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

/// GetOffersParams
class GetOffersParams {
  /// Default constructor
  GetOffersParams({
    required this.latitude,
    required this.longitude,
  });

  /// Latitude
  final double latitude;

  /// Longitude
  final double longitude;
}
