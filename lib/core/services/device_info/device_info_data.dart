import 'package:device_info_plus/device_info_plus.dart';
import 'package:flow_zero_waste/core/services/device_info/device_info_enum.dart';
import 'package:flutter/foundation.dart';

/// DeviceInfoData class
@immutable
class DeviceInfoData {
  /// DeviceInfoData constructor
  const DeviceInfoData({
    required this.deviceId,
    required this.deviceLocale,
    required this.deviceModel,
    required this.deviceOemName,
    required this.deviceOsVersion,
  });

  /// factory from WebBrowserInfo
  factory DeviceInfoData.fromWebBrowser(WebBrowserInfo webBrowserInfo) {
    return DeviceInfoData(
      deviceId: webBrowserInfo.userAgent,
      deviceModel: '${webBrowserInfo.platform}, ${webBrowserInfo.product}',
      deviceOemName: webBrowserInfo.vendor,
      deviceOsVersion: webBrowserInfo.appVersion,
      deviceLocale: webBrowserInfo.language,
    );
  }

  /// factory from IosDeviceInfo
  factory DeviceInfoData.fromIosDevice(IosDeviceInfo iosDeviceInfo) {
    return DeviceInfoData(
      deviceId: iosDeviceInfo.identifierForVendor,
      deviceLocale: '${iosDeviceInfo.name} ${iosDeviceInfo.systemName}',
      deviceModel:
          '${iosDeviceInfo.utsname.machine} ${iosDeviceInfo.utsname.sysname}',
      deviceOemName: iosDeviceInfo.localizedModel,
      deviceOsVersion: iosDeviceInfo.systemVersion,
    );
  }

  /// factory from AndroidDeviceInfo
  factory DeviceInfoData.fromAndroidDevice(
    AndroidDeviceInfo androidDeviceInfo,
  ) {
    return DeviceInfoData(
      deviceId: androidDeviceInfo.serialNumber,
      deviceLocale: null,
      deviceModel: '${androidDeviceInfo.model} ${androidDeviceInfo.device}',
      deviceOemName:
          '${androidDeviceInfo.manufacturer} ${androidDeviceInfo.brand}',
      deviceOsVersion:
          '${androidDeviceInfo.version.release} ${androidDeviceInfo.id}',
    );
  }

  /// factory from BaseDeviceInfo
  factory DeviceInfoData.fromBaseDeviceInfo(
    BaseDeviceInfo baseDeviceInfo,
    DevicePlatform platform,
  ) {
    if (platform == DevicePlatform.android) {
      return DeviceInfoData.fromAndroidDevice(
        baseDeviceInfo as AndroidDeviceInfo,
      );
    } else if (platform == DevicePlatform.ios) {
      return DeviceInfoData.fromIosDevice(
        baseDeviceInfo as IosDeviceInfo,
      );
    } else if (platform == DevicePlatform.web) {
      return DeviceInfoData.fromWebBrowser(
        baseDeviceInfo as WebBrowserInfo,
      );
    } else {
      return const DeviceInfoData(
        deviceId: null,
        deviceLocale: null,
        deviceModel: null,
        deviceOemName: null,
        deviceOsVersion: null,
      );
    }
  }

  /// device id
  final String? deviceId;

  /// device locale
  final String? deviceLocale;

  /// device model
  final String? deviceModel;

  /// device oem name
  final String? deviceOemName;

  /// device os version
  final String? deviceOsVersion;
}
