import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/discover/data/models/banner_model.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/banner.dart';

/// BannerMapper
class BannerMapper extends Mapper<BannerModel, Banner> {
  @override
  Banner from(BannerModel object) {
    return Banner(
      id: object.id,
      title: object.title,
      description: object.description,
      imageUrl: object.imageUrl,
    );
  }

  @override
  BannerModel to(Banner object) {
    return BannerModel(
      id: object.id,
      title: object.title,
      description: object.description,
      imageUrl: object.imageUrl,
    );
  }

  
}