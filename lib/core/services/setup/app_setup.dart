import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_zero_waste/config/firebase/firebase.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/initialization/initialization_provider.dart';
import 'package:flow_zero_waste/core/enums/build_type_enum.dart';
import 'package:flow_zero_waste/core/services/setup/app_env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger_manager/logger_manager.dart';

/// AppSetup is a class that initializes the app.
class AppSetup {
  /// The AppSetup initialization.
  static FutureOr<void> init<T>({
    required BuildType buildType,
    required Widget success,
    required Widget failure,
    Iterable<Future<T>> Function(GetIt locator)? initialize,
  }) async {
    if (AppEnv.isInitialized) {
      _init<T>(
        isSuccess: true,
        app: success,
        buildType: buildType,
        initialize: initialize,
      );
    } else {
      _init<T>(
        isSuccess: false,
        app: failure,
        buildType: buildType,
        initialize: initialize,
      );
    }
  }

  /// `_init` method should be called
  /// when the app is initialized successfully.
  static FutureOr<void> _init<T>({
    required bool isSuccess,
    required Widget app,
    required BuildType buildType,
    Iterable<Future<T>> Function(GetIt locator)? initialize,
  }) async {
    if (!isSuccess) {
      // set the app environment
      AppEnv.set(
        apiUrl: '',
        clientId: '',
        clientSecret: '',
        // TODO(add): add default error host end error instrumentation key
        errorHost: '',
        errorInstrumentationKey: '',
        buildType: buildType,
      );
    }

    // ensure widgets binding is initialized
    final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

    // preserve the splash screen
    if (initialize != null) {
      InitializationStatus().preserve(widgetBinding);
    }

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

    // initialize the app
    if (initialize != null) {
      await InitializationStatus().initialize(initialize(locator));
    }
    
    // run application
    runApp(app);
  }

  /// `_onError` method should be called to catch flutter and platform errors.
  static void _onError(LoggerManager logManager) {
    // catch flutter errors
    FlutterError.onError = (details) {
      if (details.library == 'rendering library') {
        logManager.trace(
          message: 'rendering library: $details',
          problemId: 'flutter_on_error',
        );
      } else {
        logManager.logger.w(
          LoggerMessage(
            message: details.toString(),
            problemId: 'flutter_on_error',
            additionalProperties: {
              'library': details.library.toString(),
              // 'diagnosticsNode': details.context.toString(),
              // 'informationCollector':
              //       details.informationCollector.toString(),
            },
          ),
          stackTrace: details.stack,
          error: details.exception,
        );
      }
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
