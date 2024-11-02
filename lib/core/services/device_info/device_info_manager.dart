import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flow_zero_waste/core/services/device_info/device_info_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// DeviceInfoManager class
///
/// class to get current device and platform information
///
/// it uses `device_info_plus` and `package_info_plus` packages
abstract class DeviceInfoManager {

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// androidInfo getter
  ///
  /// from `device_info_plus` package
  Future<AndroidDeviceInfo> get androidInfo => _deviceInfoPlugin.androidInfo;

  /// iosInfo getter
  ///
  /// from `device_info_plus` package
  Future<IosDeviceInfo> get iosInfo => _deviceInfoPlugin.iosInfo;

  /// webBrowserInfo getter
  ///
  /// from `device_info_plus` package
  Future<WebBrowserInfo> get webBrowserInfo => _deviceInfoPlugin.webBrowserInfo;

  /// baseInfo getter
  ///
  /// from `device_info_plus` package
  Future<BaseDeviceInfo> get baseInfo => _deviceInfoPlugin.deviceInfo;

  /// package getter
  ///
  /// from `package_info_plus` package
  Future<PackageInfo> get package => PackageInfo.fromPlatform();

  /// decide on which platform the app is running:
  /// ios, android, web, unknown
  DevicePlatform get platform {
    if (Platform.isAndroid) {
      return DevicePlatform.android;
    } else if (Platform.isIOS) {
      return DevicePlatform.ios;
    } else if (kIsWeb) {
      return DevicePlatform.web;
    }
    return DevicePlatform.unknown;
  }
}
