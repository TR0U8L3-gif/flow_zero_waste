import 'package:flow_zero_waste/core/common/data/exceptions.dart';

/// UnableToGetBannerDataException
class GetFavoritesException extends BaseException {
  /// Default constructor
  GetFavoritesException({
    required super.error,
    required super.action,
    super.stackTrace,
  });
}
