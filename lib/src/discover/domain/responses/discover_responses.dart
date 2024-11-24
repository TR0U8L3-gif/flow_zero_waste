import 'package:flow_zero_waste/core/common/domain/response.dart';

/// Discover failure
sealed class DiscoverFailure extends Failure {
  /// Default constructor
  const DiscoverFailure();
}

/// UnableToGetBannerDataFailure
class UnableToGetBannerDataFailure extends DiscoverFailure {
  /// Default constructor
  const UnableToGetBannerDataFailure();
}

/// UnableToGetCategoryDataFailure
class UnableToGetCategoryDataFailure extends DiscoverFailure {
  /// Default constructor
  const UnableToGetCategoryDataFailure();
}

/// UnableToGetOfferDataFailure
class UnableToGetOfferDataFailure extends DiscoverFailure {
  /// Default constructor
  const UnableToGetOfferDataFailure();
}

/// UnableToGetShopDataFailure
class UnableToGetShopDataFailure extends DiscoverFailure {
  /// Default constructor
  const UnableToGetShopDataFailure();
}

/// UnableToLikeShopFailure
class UnableToLikeShopFailure extends DiscoverFailure {
  /// Default constructor
  const UnableToLikeShopFailure();
}
