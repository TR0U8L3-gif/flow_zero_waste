import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/language/domain/repositories/language_repository.dart';
import 'package:injectable/injectable.dart';

/// SaveLanguage use case
@lazySingleton
class SaveLanguageToLocalStorage
    extends UseCase<void, SaveLanguageToStorageParams> {
  /// Constructor for SaveLanguage
  SaveLanguageToLocalStorage({required LanguageRepository repository})
      : _repository = repository;
  final LanguageRepository _repository;

  @override
  ResultFuture<Failure, void> call(SaveLanguageToStorageParams params) {
    return _repository.saveLanguageToStorage(params.languageCode);
  }
}

/// Parameters for SaveLanguage
class SaveLanguageToStorageParams {
  /// Constructor for SaveLanguageParams
  SaveLanguageToStorageParams({required this.languageCode});

  /// Language code
  final String languageCode;
}
