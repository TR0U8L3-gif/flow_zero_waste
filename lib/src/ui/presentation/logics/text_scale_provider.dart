import 'package:flow_zero_waste/core/enums/text_enum.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const _textScaleFactorDefault = 1.0;
const _textScaleFactorMinDefault = 0.4;
const _textScaleFactorMaxDefault = 2.2;

@singleton
/// A provider class to manage the text scale of the app.
class TextScaleProvider extends ChangeNotifier {
  /// Factory constructor to return the instance of the text scale provider.
  factory TextScaleProvider() => _instance;

  /// Constructor to initialize the text scale provider.
  TextScaleProvider._initial([
    double min = _textScaleFactorMinDefault,
    double max = _textScaleFactorMaxDefault,
  ]) {
    setTextScaleFactorConstraints(min, max);
  }

  static final TextScaleProvider _instance = TextScaleProvider._initial();

  double _textScaleFactor = _textScaleFactorDefault;
  double _textScaleFactorMin = _textScaleFactorMinDefault;
  double _textScaleFactorMax = _textScaleFactorMaxDefault;

  /// Getter for the text scale factor.
  double get textScaleFactor => _textScaleFactor;

  /// Getter for the minimum text scale factor.
  double get textScaleFactorMin => _textScaleFactorMin;

  /// Getter for the maximum text scale factor.
  double get textScaleFactorMax => _textScaleFactorMax;

  /// Getter for the text scale.
  TextScale get textScale => TextScale.fromDouble(_textScaleFactor);

  /// Getter for the text scaler.
  TextScaler get textScaler => TextScaler.linear(_textScaleFactor).clamp(
        minScaleFactor: _textScaleFactorMin,
        maxScaleFactor: _textScaleFactorMax,
      );

  /// Method to set the text scale factor.
  void setTextScaleFactor(double scale) {
    var textScale = scale;
    if (scale > _textScaleFactorMax) {
      textScale = _textScaleFactorMax;
    } 
    if (scale < _textScaleFactorMin) {
      textScale = _textScaleFactorMin;
    } 
    _textScaleFactor = textScale;
    notifyListeners();
  }

  /// Method to set the text scale factor constraints.
  void setTextScaleFactorConstraints(double min, double max) {
    if (min <= 0 || max - min < _textScaleFactorDefault) {
      return;
    }
    _textScaleFactorMin = min;
    _textScaleFactorMax = max;
    notifyListeners();
  }
}
