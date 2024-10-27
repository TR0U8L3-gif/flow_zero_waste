import 'package:flow_zero_waste/core/utils/repository.dart';
import 'package:flow_zero_waste/core/utils/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/language/data/datasources/language_local_data_sorce.dart';
import 'package:flow_zero_waste/src/language/domain/repositories/language_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Language repository implementation
@LazySingleton(as: LanguageRepository)
class LanguageRepositoryImpl extends Repository implements LanguageRepository {
  /// Constructor for LanguageRepositoryImpl
  LanguageRepositoryImpl({
    required LanguageLocalDataSorce languageLocalDataSorce,
  }) : _languageLocalDataSorce = languageLocalDataSorce;

  final LanguageLocalDataSorce _languageLocalDataSorce;

  @override
  ResultFuture<Failure, String?> getLanguageFromStorage() async {
    try {
      logger.trace(message: 'Getting language code from local storage');
      final languageCode =
          await _languageLocalDataSorce.getLanguageFromStorage();

      logger.trace(
        message: 'Received language code from local storage: $languageCode',
      );

      return Right(languageCode);
    } catch (e, st) {
      logger.warning(
        message: 'Error getting language code from local storage: $e',
        stackTrace: st,
      );
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  ResultFuture<Failure, void> saveLanguageToStorage(String languageCode) async {
    try {
      logger.trace(
        message: 'Saving language code ($languageCode) to local storage',
      );
      await _languageLocalDataSorce.saveLanguageToStorage(languageCode);
      logger.trace(
        message: 'Language code ($languageCode) saved to local storage',
      );
      return const Right(null);
    } catch (e, st) {
      logger.warning(
        message: 'Error saving language code to local storage: $e',
        stackTrace: st,
      );
      return Left(Failure(message: e.toString()));
    }
  }
}
