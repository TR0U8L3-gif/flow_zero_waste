import 'package:flow_zero_waste/core/enums/build_type_enum.dart';
import 'package:flow_zero_waste/core/services/setup/app_env.dart';
import 'package:injectable/injectable.dart';

/// LoggerManagerParametersFromAppEnv class for the logger manager parameters.
@Singleton(as: LoggerManagerParameters)
class LoggerManagerParametersFromAppEnv extends LoggerManagerParameters {
  /// LoggerManagerParametersFromAppEnv constructor
  LoggerManagerParametersFromAppEnv()
      : super(
          buildType: AppEnv().buildType,
          errorHost: AppEnv().errorHost,
          errorInstrumentationKey: AppEnv().errorInstrumentationKey,
        );
}

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
