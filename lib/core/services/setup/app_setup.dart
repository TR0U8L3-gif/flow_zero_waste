import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_zero_waste/config/firebase/firebase.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/enums/build_type.dart';
import 'package:flow_zero_waste/core/services/device_info/device_info.dart';
import 'package:flow_zero_waste/core/services/logger_manager/logger_manager.dart';
import 'package:flow_zero_waste/core/services/setup/app_env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger_manager/logger_manager.dart';

/// AppSetup is a class that initializes the app.
class AppSetup {
  /// The AppSetup initialization.
  static FutureOr<void> init({
    required Widget success,
    required Widget failure,
  }) async {
    if (AppEnv.isInitialized) {
      initSuccess(success);
    } else {
      initFailure(failure);
    }
  }

  /// `initSuccess` method should be called
  /// when the app is initialized successfully.
  static FutureOr<void> initSuccess(Widget app) async {
    // ensure widgets binding is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // initialize hive
    await Hive.initFlutter();

    // initialize firebase
    await Firebase.initializeApp(
      options: FirebaseOptionsManager.currentFlavorPlatform,
    );

    // configure service locator dependencies
    configureDependencies();

    // wait for all dependencies to be ready
    await locator.allReady();

    // create logger based on the environment
    final logManager = locator<LoggerManager>()
      ..createLogger(type: AppEnv().buildType.name);

    // catch errors
    _onError(logManager);

    // run application
    runApp(app);
  }

  /// `initFailure` method should be called when the app initialization fails.
  static FutureOr<void> initFailure(Widget app) async {
    // ensure widgets binding is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // initialize firebase
    await Firebase.initializeApp(
      options: FirebaseOptionsManager.currentFlavorPlatform,
    );

    // ignore locator configuration

    // get build type based on the environment
    BuildType buildType;

    if (kDebugMode) {
      buildType = BuildType.debug;
    } else if (kProfileMode) {
      buildType = BuildType.profile;
    } else {
      buildType = BuildType.release;
    }

    // create logger parameters based on the environment
    final logManagerParameters = LoggerManagerParameters(
      buildType: buildType,
    );

    // create logger based on the environment
    final logManager = LoggerManagerImplementation(
      deviceInfo: DeviceInfoImplementation(),
      parameters: logManagerParameters,
    )..createLogger(type: buildType.name);

    // catch errors
    _onError(logManager);

    // run application
    runApp(app);
  }

  /// `_onError` method should be called to catch flutter and platform errors.
  static void _onError(LoggerManager logManager) {
    // catch flutter errors
    FlutterError.onError = (details) {
      logManager.logger.w(
        LoggerMessage(
          message: details.toString(),
          problemId: 'flutter_on_error',
          additionalProperties: {
            'library': details.library.toString(),
            // 'diagnosticsNode': details.context.toString(),
            // 'informationCollector': details.informationCollector.toString(),
          },
        ),
        stackTrace: details.stack,
        error: details.exception,
      );
    };

    // catch platform dispatcher errors
    PlatformDispatcher.instance.onError = (error, stack) {
      logManager.logger.e(
        LoggerMessage(
          message: error.toString(),
          problemId: 'platform_dispatcher_on_error',
        ),
        stackTrace: stack,
        error: error,
      );
      if (kDebugMode) {
        // in debug mode, we want to see the error
        return false;
      } else {
        // in release mode, we want to ignore the error
        return true;
      }
    };
  }
}
