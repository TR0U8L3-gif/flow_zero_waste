import 'package:flow_zero_waste/core/common/data/exceptions.dart';

/// UnableToGetBannerDataException
class UnableToGetBannerDataException extends BaseException {
  /// Default constructor
  UnableToGetBannerDataException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// UnableToGetCategoryDataException
class UnableToGetCategoryDataException extends BaseException {
  /// Default constructor
  UnableToGetCategoryDataException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// UnableToGetOfferDataException
class UnableToGetOfferDataException extends BaseException {
  /// Default constructor
  UnableToGetOfferDataException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// UnableToGetShopDataException
class UnableToGetShopDataException extends BaseException {
  /// Default constructor
  UnableToGetShopDataException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}

/// UnableToLikeShopException
class UnableToLikeShopException extends BaseException {
  /// Default constructor
  UnableToLikeShopException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}
