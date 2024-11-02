import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

const _splashTimeout = 15;

/// A class to manage the initialization status of the app.
class InitializationStatus {

  /// Factory constructor for [InitializationStatus].
  factory InitializationStatus() => _instance;
  
  InitializationStatus._internal();

  static final InitializationStatus _instance =
      InitializationStatus._internal();

  InitializationState _state = InitializationState.uninitialized;

  /// Getter for the initialization state.
  InitializationState get state => _state;

  /// Method to preserve the splash screen.
  void preserve(WidgetsBinding widgetsBinding) {
    if (_instance._state != InitializationState.uninitialized) {
      return;
    }

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    Timer(
      const Duration(seconds: _splashTimeout),
      remove,
    );
  }

  /// Method to initialize the app.
  void initialize<T>(
    Iterable<Future<T>> futures,
  ) {
    if (_instance._state != InitializationState.uninitialized) {
      return;
    }
    _instance._state = InitializationState.initializing;
    Future.wait(futures).then(
      (_) => remove(),
    );
  }

  /// Method to remove the splash screen.
  void remove() {
    if(_instance._state == InitializationState.initialized) {
      return;
    }
    _instance._state = InitializationState.initialized;
    FlutterNativeSplash.remove();
  }
}

/// Enum for the initialization state.
enum InitializationState {
  /// Uninitialized state.
  uninitialized,

  /// Initializing state.
  initializing,

  /// Initialized state.
  initialized,
}
