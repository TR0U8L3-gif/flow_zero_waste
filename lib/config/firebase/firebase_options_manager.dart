import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flow_zero_waste/config/firebase/firebase_options.dart' as dev;
import 'package:flow_zero_waste/config/firebase/firebase_options.dart' as demo;
import 'package:flow_zero_waste/config/firebase/firebase_options.dart' as prod;


/// Firebase Options Manager
///
/// This class is used to manage the FirebaseOptions for different flavours.
class FirebaseOptionsManager {
  /// get current platform config for flavour
  static FirebaseOptions? get currentFlavorPlatform {
    switch (appFlavor) {
      case 'development':
        return dev.DefaultFirebaseOptions.currentPlatform;
      case 'demonstration':
        return demo.DefaultFirebaseOptions.currentPlatform;
      case 'production':
        return prod.DefaultFirebaseOptions.currentPlatform;
      default:
        log('FirebaseOptionsManager: No FirebaseOptions found for $appFlavor');
        return null;
    }
  }
}
