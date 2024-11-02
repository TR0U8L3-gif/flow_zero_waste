import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/text_scale_details.dart';
import 'package:flow_zero_waste/src/ui/domain/repository/ui_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case to save text scale details to local storage.
@lazySingleton
class SaveTextScaleFromLocalStorage
    extends UseCase<void, SaveTextScaleFromLocalStorageParams> {
  /// Constructor for [SaveTextScaleFromLocalStorage].
  SaveTextScaleFromLocalStorage({required UiRepository repository})
      : _repository = repository;
  final UiRepository _repository;

  @override
  ResultFuture<Failure, void> call(SaveTextScaleFromLocalStorageParams params) {
    return _repository.saveTextScaleDetailsToStorage(params.textScaleDetails);
  }
}

/// Parameters for [SaveTextScaleFromLocalStorage].
class SaveTextScaleFromLocalStorageParams {
  /// Constructor for [SaveTextScaleFromLocalStorageParams].
  SaveTextScaleFromLocalStorageParams({required this.textScaleDetails});

  /// Text scale details entity
  final TextScaleDetails textScaleDetails;
}
