import 'package:flow_zero_waste/core/enums/build_type_enum.dart';
import 'package:flow_zero_waste/core/services/setup/app_exceptions.dart';
import 'package:flutter/material.dart';

/// AppEnv is a class that holds the environment variables for the app.
@immutable
class AppEnv {
  /// Initializes the AppEnv instance.
  ///
  /// `set` method should be called before the AppEnv instance is used.
  factory AppEnv() {
    return _instance == null
        ? throw AppEnvException(
            error: 'Instance is empty',
            action: 'grt instance',
            stackTrace: StackTrace.current,
          )
        : _instance!;
  }

  /// The AppEnv private constructor.
  const AppEnv._({
    required this.apiUrl,
    required this.clientId,
    required this.clientSecret,
    required this.buildType,
    this.errorHost,
    this.errorInstrumentationKey,
  });

  /// Sets the environment variables for the app.
  /// This method should be called before the AppEnv instance is used.
  static void setFromEnv({
    required Map<String, String> env,
    required String flavour,
    required BuildType buildType,
  }) {
    final errorMessage = StringBuffer();

    final variablesNamesRequired = <String>[
      'apiUrl_$flavour',
      'clientId_$flavour',
      'clientSecret_$flavour',
    ];

    final variablesNamesOptional = <String>[
      'errorHost_$flavour',
      'errorInstrumentationKey_$flavour',
    ];

    for (final key in variablesNamesRequired) {
      if (!env.containsKey(key)) {
        errorMessage.writeln(
          '(AppEnv.setFromMap) Error: $key is not found in the .env',
        );
      }
      if (env[key] == null) {
        errorMessage.writeln(
          '(AppEnv.setFromMap) Error: $key is null',
        );
      }
    }

    if (errorMessage.isNotEmpty) {
      throw AppEnvException(
        error: errorMessage.toString(),
        action: 'set data from env',
        stackTrace: StackTrace.current,
      );
    }

    try {
      set(
        apiUrl: env[variablesNamesRequired.first]!,
        clientId: env[variablesNamesRequired[1]]!,
        clientSecret: env[variablesNamesRequired.last]!,
        errorHost: env[variablesNamesOptional.first],
        errorInstrumentationKey: env[variablesNamesOptional.last],
        buildType: buildType,
      );
    } catch (e, st) {
      throw AppEnvException(
        error: e,
        action: 'set data from env',
        stackTrace: st,
      );
    }
  }

  /// Set the environment variables for the app from map.
  /// This method should be called before the AppEnv instance is used.
  static void set({
    required String apiUrl,
    required String clientId,
    required String clientSecret,
    required BuildType buildType, 
    String? errorHost,
    String? errorInstrumentationKey,
  }) {
    _instance = AppEnv._(
      apiUrl: apiUrl,
      clientId: clientId,
      clientSecret: clientSecret,
      buildType: buildType,
      errorHost: errorHost,
      errorInstrumentationKey: errorInstrumentationKey,
    );
  }

  /// Clears the AppEnv instance.
  static void clear() {
    _instance = null;
  }

  /// Returns true if the AppEnv instance is initialized.
  static bool get isInitialized => _instance != null;

  /// The AppEnv instance.
  static AppEnv? _instance;

  /// The API URL for the app.
  final String apiUrl;

  /// The client ID for the app.
  final String clientId;

  /// The client secret for the app.
  final String clientSecret;

  /// Build type
  final BuildType buildType;

  /// The host for the app.
  final String? errorHost;

  /// The instrumentation key for the app.
  final String? errorInstrumentationKey;
}
