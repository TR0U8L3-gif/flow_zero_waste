import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/category.dart';
import 'package:flow_zero_waste/src/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

/// GetCategories
@singleton
class GetCategories extends UseCase<List<Category>, GetCategoriesParams> {
  /// Default constructor
  GetCategories({required DiscoverRepository repository})
      : _repository = repository;
  final DiscoverRepository _repository;

  @override
  ResultFuture<Failure, List<Category>> call(GetCategoriesParams params) {
    return _repository.getCategories(languageCode: params.languageCode);
  }
}

/// GetCategoriesParams
class GetCategoriesParams {
  /// Default constructor
  GetCategoriesParams({required this.languageCode});

  /// Language code
  final String languageCode;
}
