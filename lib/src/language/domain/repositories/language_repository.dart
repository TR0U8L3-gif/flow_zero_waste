import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';

/// abstract Language repository
abstract class LanguageRepository{
  /// Save language code to local storage
  ResultFuture<Failure, void> saveLanguageToStorage(String languageCode);

  /// Get language code from local storage
  ResultFuture<Failure, String?> getLanguageFromStorage();
}
