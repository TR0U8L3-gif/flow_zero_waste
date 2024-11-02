import 'package:flow_zero_waste/core/common/data/exceptions.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/ui/data/datasource/ui_local_data_source.dart';
import 'package:flow_zero_waste/src/ui/data/mappers/text_scale_details_mapper.dart';
import 'package:flow_zero_waste/src/ui/data/mappers/theme_details_mapper.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/text_scale_details.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/theme_details.dart';
import 'package:flow_zero_waste/src/ui/domain/repository/ui_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

/// UI repository implementation
@Singleton(as: UiRepository)
class UiRepositoryImpl  implements UiRepository {
  /// Ui repository constructor
  UiRepositoryImpl({
    required TextScaleDetailsMapper textScaleDetailsMapper,
    required ThemeDetailsMapper themeDetailsMapper,
    required UiLocalDataSource uiLocalDataSource,
    required LoggerManager logger,
  })  : _textScaleDetailsMapper = textScaleDetailsMapper,
        _themeDetailsMapper = themeDetailsMapper,
        _uiLocalDataSource = uiLocalDataSource,
        _logger = logger;

  final TextScaleDetailsMapper _textScaleDetailsMapper;
  final ThemeDetailsMapper _themeDetailsMapper;
  final UiLocalDataSource _uiLocalDataSource;
  final LoggerManager _logger;

  @override
  ResultFuture<Failure, TextScaleDetails?>
      loadTextScaleDetailsFromStorage() async {
    const errorMessage = 'Error getting text scale details from local storage';

    try {
      _logger.trace(message: 'Getting text scale details from local storage');

      final textScaleDetailsModel =
          await _uiLocalDataSource.loadTextScaleDetailsFromStorage();

      _logger.trace(
        message: 'Received text scale details from '
            'local storage: $textScaleDetailsModel',
      );

      if (textScaleDetailsModel == null) {
        return const Right(null);
      }

      final textScaleDetails =
          _textScaleDetailsMapper.from(textScaleDetailsModel);

      return Right(textScaleDetails);
    } on LocalStorageException catch (e) {
      _logger.warning(
        message: e.message,
        error: e,
        stackTrace: e.stackTrace,
      );
      return const Left(Failure(message: errorMessage));
    } catch (e, st) {
      _logger.warning(
        message: errorMessage,
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: errorMessage));
    }
  }

  @override
  ResultFuture<Failure, ThemeDetails?> loadThemeDetailsFromStorage() async {
    const errorMessage = 'Error getting theme details from local storage';
    try {
      _logger.trace(message: 'Getting theme details from local storage');

      final themeDetailsModel =
          await _uiLocalDataSource.loadThemeDetailsFromStorage();

      _logger.trace(
        message: 'Received theme details from '
            'local storage: $themeDetailsModel',
      );

      if (themeDetailsModel == null) {
        return const Right(null);
      }

      final themeDetails = _themeDetailsMapper.from(themeDetailsModel);

      return Right(themeDetails);
    } on LocalStorageException catch (e) {
      _logger.warning(
        message: e.message,
        error: e,
        stackTrace: e.stackTrace,
      );
      return const Left(Failure(message: errorMessage));
    } catch (e, st) {
      _logger.warning(
        message: errorMessage,
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: errorMessage));
    }
  }

  @override
  ResultFuture<Failure, void> saveTextScaleDetailsToStorage(
    TextScaleDetails textScale,
  ) async {
    const errorMessage = 'Error saving text scale details to local storage';
    try {
      _logger.trace(message: 'Saving text scale details to local storage');

      final textScaleDetailsModel = _textScaleDetailsMapper.to(textScale);
      await _uiLocalDataSource
          .saveTextScaleDetailsToStorage(textScaleDetailsModel);

      _logger.trace(message: 'Text scale details saved to local storage');

      return const Right(null);
    } on LocalStorageException catch (e) {
      _logger.warning(
        message: e.message,
        error: e,
        stackTrace: e.stackTrace,
      );
      return const Left(Failure(message: errorMessage));
    } catch (e, st) {
      _logger.warning(
        message: errorMessage,
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: errorMessage));
    }
  }

  @override
  ResultFuture<Failure, void> saveThemeDetailsToStorage(
    ThemeDetails themeDetails,
  ) async {
    const errorMessage = 'Error saving theme details to local storage';
    try {
      _logger.trace(message: 'Saving theme details to local storage');

      final themeDetailsModel = _themeDetailsMapper.to(themeDetails);
      await _uiLocalDataSource.saveThemeDetailsToStorage(themeDetailsModel);

      _logger.trace(message: 'Theme details saved to local storage');

      return const Right(null);
    } on LocalStorageException catch (e) {
      _logger.warning(
        message: e.message,
        error: e,
        stackTrace: e.stackTrace,
      );
      return const Left(Failure(message: errorMessage));
    } catch (e, st) {
      _logger.warning(
        message: errorMessage,
        error: e,
        stackTrace: st,
      );
      return const Left(Failure(message: errorMessage));
    }
  }
}
