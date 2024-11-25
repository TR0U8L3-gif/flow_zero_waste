import 'package:flow_zero_waste/core/common/domain/response.dart';

/// Favorites failure
sealed class FavoritesFailure extends Failure {
  /// Default constructor
  const FavoritesFailure();
}

/// GetFavoritesFailure
class GetFavoritesFailure extends FavoritesFailure {
  /// Default constructor
  const GetFavoritesFailure();
}
