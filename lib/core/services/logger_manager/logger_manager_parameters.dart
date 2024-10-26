import 'package:flow_zero_waste/core/enums/build_type.dart';

class LoggerManagerParameters {
  
  LoggerManagerParameters({
    required this.buildType,
    this.errorHost,
    this.errorInstrumentationKey,
  });

  /// Build type
  final BuildTypes buildType;

  /// The host for the app.
  final String? errorHost;

  /// The instrumentation key for the app.
  final String? errorInstrumentationKey;
}
