import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/src/language/domain/repositories/language_repository.dart';
import 'package:injectable/injectable.dart';


/// Get language from storage use case
@lazySingleton
class GetLanguageFromLocalStorage extends UseCase<String?, NoParams> {
  ///  Constructor for GetLanguageFromStorage
  GetLanguageFromLocalStorage({required LanguageRepository repository})
      : _repository = repository;
  final LanguageRepository _repository;

  @override
  ResultFuture<Failure, String?> call(NoParams params) {
    return _repository.getLanguageFromStorage();
  }
}
