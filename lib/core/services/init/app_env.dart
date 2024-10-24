import 'package:flow_zero_waste/core/enums/build_type.dart';
import 'package:flow_zero_waste/core/utils/exceptions.dart';
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
            sender: 'AppEnv._instance',
            description: 'not initialized',
          )
        : _instance!;
  }

  /// The AppEnv private constructor.
  const AppEnv._({
    required this.apiUrl,
    required this.clientId,
    required this.clientSecret,
    required this.buildType,
    required this.errorHost,
    required this.errorInstrumentationKey,
  });

  /// Sets the environment variables for the app.
  /// This method should be called before the AppEnv instance is used.
  static void setFromMap({
    required Map<String, String> env,
    required String postfix,
  }) {
    final variablesNames = <String>[
      'apiUrl$postfix',
      'clientId$postfix',
      'clientSecret$postfix',
      'errorHost$postfix',
      'errorInstrumentationKey$postfix',
      'buildType$postfix',
    ];

    for (final key in variablesNames) {
      if (!env.containsKey(key)) {
        throw Exception(
          '(AppEnv.setFromMap) Error: $key is not found in the .env',
        );
      }
      if (env[key] == null) {
        throw Exception(
          '(AppEnv.setFromMap) Error: $key is null',
        );
      }
    }

    BuildTypes buildType;

    try {
      buildType = BuildTypes.values.byName(env[variablesNames[5]]!);
    } catch (e) {
      throw Exception(
        '(AppEnv.setFromMap) Error: buildType$postfix is not a valid BuildType',
      );
    }

    set(
      apiUrl: env[variablesNames[0]]!,
      clientId: env[variablesNames[1]]!,
      clientSecret: env[variablesNames[2]]!,
      errorHost: env[variablesNames[3]]!,
      errorInstrumentationKey: env[variablesNames[4]]!,
      buildType: buildType,
    );
  }

  /// Set the environment variables for the app from map.
  /// This method should be called before the AppEnv instance is used.
  static void set({
    required String apiUrl,
    required String clientId,
    required String clientSecret,
    required String errorHost,
    required String errorInstrumentationKey,
    required BuildTypes buildType,
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
  final BuildTypes buildType;

  /// The host for the app.
  final String errorHost;

  /// The instrumentation key for the app.
  final String errorInstrumentationKey;
}
