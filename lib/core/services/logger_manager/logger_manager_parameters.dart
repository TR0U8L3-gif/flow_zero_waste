import 'package:flow_zero_waste/core/enums/build_type_enum.dart';

/// LoggerManagerParameters is a class that holds 
/// the parameters for the logger manager.
class LoggerManagerParameters {
  /// Initializes the LoggerManagerParameters instance.
  const LoggerManagerParameters({
    required this.buildType,
    this.errorHost,
    this.errorInstrumentationKey,
  });

  /// Build type
  final BuildType buildType;

  /// The host for the app.
  final String? errorHost;

  /// The instrumentation key for the app.
  final String? errorInstrumentationKey;
}
