import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/language/data/datasources/language_local_data_sorce.dart';
import 'package:flow_zero_waste/src/language/domain/repositories/language_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

/// Language repository implementation
@Singleton(as: LanguageRepository)
class LanguageRepositoryImpl implements LanguageRepository {
  /// Constructor for LanguageRepositoryImpl
  LanguageRepositoryImpl({
    required LanguageLocalDataSorce languageLocalDataSorce,
    required LoggerManager logger,
  })  : _languageLocalDataSorce = languageLocalDataSorce,
        _logger = logger;

  final LanguageLocalDataSorce _languageLocalDataSorce;
  final LoggerManager _logger;

  @override
  ResultFuture<Failure, String?> loadLanguageFromStorage() async {
    try {
      _logger.trace(message: 'Getting language code from local storage');
      final languageCode =
          await _languageLocalDataSorce.loadLanguageFromStorage();

      _logger.trace(
        message: 'Received language code from local storage: $languageCode',
      );

      return Right(languageCode);
    } catch (e, st) {
      _logger.warning(
        message: 'Error getting language code from local storage: $e',
        stackTrace: st,
      );
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  ResultFuture<Failure, void> saveLanguageToStorage(String languageCode) async {
    try {
      _logger.trace(
        message: 'Saving language code ($languageCode) to local storage',
      );
      await _languageLocalDataSorce.saveLanguageToStorage(languageCode);
      _logger.trace(
        message: 'Language code ($languageCode) saved to local storage',
      );
      return const Right(null);
    } catch (e, st) {
      _logger.warning(
        message: 'Error saving language code to local storage: $e',
        stackTrace: st,
      );
      return Left(Failure(message: e.toString()));
    }
  }
}
