import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/theme_details.dart';
import 'package:flow_zero_waste/src/ui/domain/repositories/ui_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case to save theme details to local storage.
@singleton
class SaveThemeToLocalStorage
    extends UseCase<void, SaveThemeFromToStorageParams> {
  /// Constructor for [SaveThemeToLocalStorage].
  SaveThemeToLocalStorage({required UiRepository repository})
      : _repository = repository;
  final UiRepository _repository;

  @override
  ResultFuture<Failure, void> call(SaveThemeFromToStorageParams params) {
    return _repository.saveThemeDetailsToStorage(params.themeDetails);
  }
}

/// Parameters for [SaveThemeToLocalStorage].
class SaveThemeFromToStorageParams {
  /// Constructor for [SaveThemeFromToStorageParams].
  SaveThemeFromToStorageParams({required this.themeDetails});

  /// Theme details entity
  final ThemeDetails themeDetails;
}
