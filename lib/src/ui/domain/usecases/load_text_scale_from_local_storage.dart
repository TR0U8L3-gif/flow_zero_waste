import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/text_scale_details.dart';
import 'package:flow_zero_waste/src/ui/domain/repository/ui_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case to load text scale details from local storage.
@lazySingleton
class LoadTextScaleFromLocalStorage
    extends UseCase<TextScaleDetails?, NoParams> {
  /// Constructor for [LoadTextScaleFromLocalStorage].
  LoadTextScaleFromLocalStorage({required UiRepository repository})
      : _repository = repository;
  final UiRepository _repository;

  @override
  ResultFuture<Failure, TextScaleDetails?> call(NoParams params) async {
    return _repository.loadTextScaleDetailsFromStorage();
  }
}
