import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/discover/data/mappers/shop_mapper.dart';
import 'package:flow_zero_waste/src/discover/data/models/offer_model.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/offer.dart';
import 'package:injectable/injectable.dart';

/// OfferMapper
@singleton
class OfferMapper extends Mapper<OfferModel, Offer> {
  /// Default constructor
  OfferMapper({required ShopMapper shopMapper}) : _shopMapper = shopMapper;

  final ShopMapper _shopMapper;

  @override
  Offer from(OfferModel object) {
    return Offer(
      id: object.id,
      rating: object.rating,
      distance: object.distance,
      newOffers: object.newOffers,
      shop: _shopMapper.from(object.shop),
    );
  }

  @override
  OfferModel to(Offer object) {
    return OfferModel(
      id: object.id,
      rating: object.rating,
      distance: object.distance,
      newOffers: object.newOffers,
      shop: _shopMapper.to(object.shop),
    );  
  }
}
