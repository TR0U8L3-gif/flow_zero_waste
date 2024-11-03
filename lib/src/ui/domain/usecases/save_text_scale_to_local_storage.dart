import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/utils/typedef.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/text_scale_details.dart';
import 'package:flow_zero_waste/src/ui/domain/repositories/ui_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case to save text scale details to local storage.
@singleton
class SaveTextScaleToLocalStorage
    extends UseCase<void, SaveTextScaleToLocalStorageParams> {
  /// Constructor for [SaveTextScaleToLocalStorage].
  SaveTextScaleToLocalStorage({required UiRepository repository})
      : _repository = repository;
  final UiRepository _repository;

  @override
  ResultFuture<Failure, void> call(SaveTextScaleToLocalStorageParams params) {
    return _repository.saveTextScaleDetailsToStorage(params.textScaleDetails);
  }
}

/// Parameters for [SaveTextScaleToLocalStorage].
class SaveTextScaleToLocalStorageParams {
  /// Constructor for [SaveTextScaleToLocalStorageParams].
  SaveTextScaleToLocalStorageParams({required this.textScaleDetails});

  /// Text scale details entity
  final TextScaleDetails textScaleDetails;
}
