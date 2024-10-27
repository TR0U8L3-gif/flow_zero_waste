import 'dart:math';

/// Extension for int
extension IntExtension on int {
  /// Get the fraction of the int divided by 100
  double get fraction => this / 100;

  /// Map the value of the int
  double mapValue(double oldMin, double oldMax, double newMin, double newMax) {
    return newMin + ((this - oldMin) / (oldMax - oldMin)) * (newMax - newMin);
  }
}

/// Extension for double
extension DoubleExtension on double {
  /// Round the double to the given number of places
  double roundToPlaces(int places) {
    final mod = pow(10.0, places).toDouble();
    return (this * mod).round().toDouble() / mod;
  }

  /// Get the fraction of the double divided by 100
  double get fraction => this / 100;

  /// Map the value of the double
  double mapValue(double oldMin, double oldMax, double newMin, double newMax) {
    return newMin + ((this - oldMin) / (oldMax - oldMin)) * (newMax - newMin);
  }
}

/// Extension for num
extension NumExtension on num {
  /// Get the fraction of the num divided by 100
  num get fraction => this / 100;

  /// Map the value of the num
  num mapValue(double oldMin, double oldMax, double newMin, double newMax) {
    return newMin + ((this - oldMin) / (oldMax - oldMin)) * (newMax - newMin);
  }
}
