import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/theme_details.dart';
import 'package:flow_zero_waste/src/ui/domain/repository/ui_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case to load theme details from local storage.
@singleton
class LoadThemeFromLocalStorage extends UseCase<ThemeDetails?, NoParams> {
  /// Constructor for [LoadThemeFromLocalStorage].
  LoadThemeFromLocalStorage({required UiRepository repository})
      : _repository = repository;
  final UiRepository _repository;

  @override
  ResultFuture<Failure, ThemeDetails?> call(NoParams params) {
    return _repository.loadThemeDetailsFromStorage();
  }
}
