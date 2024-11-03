import 'dart:async';

import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/enums/text_enum.dart';
import 'package:flow_zero_waste/src/ui/domain/entities/text_scale_details.dart';
import 'package:flow_zero_waste/src/ui/domain/usecases/load_text_scale_from_local_storage.dart';
import 'package:flow_zero_waste/src/ui/domain/usecases/save_text_scale_from_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const _textScaleFactorDefault = 1.0;
const _textScaleFactorMinDefault = 0.4;
const _textScaleFactorMaxDefault = 2.2;

const _timerSaveDuration = 5;

/// A provider class to manage the text scale of the app.
@singleton
class TextScaleProvider extends ChangeNotifier {
  /// Constructor for [TextScaleProvider].
  TextScaleProvider({
    required LoadTextScaleFromLocalStorage loadTextScaleFromLocalStorage,
    required SaveTextScaleFromLocalStorage saveTextScaleFromLocalStorage,
  })  : _loadTextScaleFromLocalStorage = loadTextScaleFromLocalStorage,
        _saveTextScaleFromLocalStorage = saveTextScaleFromLocalStorage;

  final LoadTextScaleFromLocalStorage _loadTextScaleFromLocalStorage;
  final SaveTextScaleFromLocalStorage _saveTextScaleFromLocalStorage;

  Timer? _saveTimer;

  TextScaleDetails _textScaleDetails = const TextScaleDetails(
    textScaleFactor: _textScaleFactorDefault,
    textScaleFactorMin: _textScaleFactorMinDefault,
    textScaleFactorMax: _textScaleFactorMaxDefault,
  );

  /// Getter for the text scale factor.
  double get textScaleFactor => _textScaleDetails.textScaleFactor;

  /// Getter for the minimum text scale factor.
  double get textScaleFactorMin => _textScaleDetails.textScaleFactorMin;

  /// Getter for the maximum text scale factor.
  double get textScaleFactorMax => _textScaleDetails.textScaleFactorMax;

  /// Getter for the text scale.
  TextScale get textScale =>
      TextScale.fromDouble(_textScaleDetails.textScaleFactor);

  /// Getter for the text scaler.
  TextScaler get textScaler =>
      TextScaler.linear(_textScaleDetails.textScaleFactor).clamp(
        minScaleFactor: _textScaleDetails.textScaleFactorMin,
        maxScaleFactor: _textScaleDetails.textScaleFactorMax,
      );

  /// Method to set the text scale factor.
  void setTextScaleFactor(double scale) {
    var textScale = scale;
    if (scale > _textScaleDetails.textScaleFactorMax) {
      textScale = _textScaleDetails.textScaleFactorMax;
    }
    if (scale < _textScaleDetails.textScaleFactorMin) {
      textScale = _textScaleDetails.textScaleFactorMin;
    }
    _textScaleDetails = _textScaleDetails.copyWith(textScaleFactor: textScale);
    notifyListeners();
    _save();
  }

  /// Method to set the text scale factor constraints.
  void setTextScaleFactorConstraints(double min, double max) {
    if (min <= 0 || max - min < _textScaleFactorDefault) {
      return;
    }
    _textScaleDetails = _textScaleDetails.copyWith(
      textScaleFactorMin: min,
      textScaleFactorMax: max,
    );
    notifyListeners();
    _save();
  }

  /// Method to load the text scale from local storage.
  Future<void> loadTextScale() async {
    final result = await _loadTextScaleFromLocalStorage(const NoParams());

    result.fold(
      (failure) => null,
      (success) {
        if (success != null) {
          _textScaleDetails = success;
          notifyListeners();
        }
      },
    );
  }

  /// Method to save the text scale to local storage.
  void saveTextScale() {
    _saveTextScaleFromLocalStorage(
      SaveTextScaleFromLocalStorageParams(textScaleDetails: _textScaleDetails),
    );
  }

  void _clearTimer() {
    if (_saveTimer != null) {
      _saveTimer!.cancel();
      _saveTimer = null;
    }
  }

  void _save() {
    _clearTimer();
    _saveTimer = Timer(
      const Duration(seconds: _timerSaveDuration),
      saveTextScale,
    );
  }
}
