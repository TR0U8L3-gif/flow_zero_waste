import 'package:device_info_plus/device_info_plus.dart';
import 'package:flow_zero_waste/core/services/device_info/device_info.dart';
import 'package:flow_zero_waste/core/services/init/app_env.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:logger_manager/logger_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

@Singleton(as: LoggerManager)

/// LoggerManagerImplementation class
class LoggerManagerImplementation extends LoggerManager {
  /// LoggerManagerImplementation constructor
  LoggerManagerImplementation({
    required DeviceInfoManager deviceInfo,
  }) : _deviceInfo = deviceInfo;

  final DeviceInfoManager _deviceInfo;

  @override
  Logger build(LoggerBuildTypes type) {
    final console = ConsoleOutputService(
      canLog: true,
      buildType: type,
      logLevel: decideLoggerBuildType<Level>(
        type,
        debug: Level.all,
        profile: Level.info,
        production: Level.warning,
      ),
    );

    final terminal = TerminalOutputService(
      canLog: true,
      buildType: type,
      maxLogsLength: 120,
      logLevel: decideLoggerBuildType<Level>(
        type,
        debug: Level.all,
        profile: Level.info,
        production: Level.warning,
      ),
    );

    final file = FileOutputService(
      canLog: decideLoggerBuildType(
        type,
        debug: true,
        profile: true,
        production: true,
      ),
      fileMaxSize: decideLoggerBuildType(
        type,
        debug: 25600,
        profile: 102400,
        production: 204800,
      ),
      buildType: type,
      logLevel: Level.all,
    );

    // TODO(feature): implement azure insights
    // final openTelemetry = OpenTelemetryOutputService(
    //   ingestionEndpoint: '${AppEnv().errorHost}/v2/track',
    //   instrumentationKey: AppEnv().errorInstrumentationKey,
    //   canLog: decideLoggerBuildType(
    //     type,
    //     debug: false,
    //     profile: true,
    //     production: true,
    //   ),
    //   logLevel: Level.all,
    //   buildType: type,
    //   telemetryContextParams: TelemetryContextParams(
    //     cloudRoleInstance: AppEnv().buildType.name,
    //     deviceType: _deviceInfo.platform.name,
    //     sessionIsFirst: true,
    //   ),
    //   capacity: decideLoggerBuildType<int>(
    //     type,
    //     debug: 48,
    //     profile: 36,
    //     production: 24,
    //   ),
    //   flushDelay: Duration(
    //     seconds: decideLoggerBuildType<int>(
    //       type,
    //       debug: 90,
    //       profile: 45,
    //       production: 15,
    //     ),
    //   ),
    // );

    final crashlytics = CrashlyticsOutputService(
      canLog: decideLoggerBuildType(
        type,
        debug: false,
        profile: true,
        production: true,
      ),
      logLevel: Level.all,
      buildType: type,
      crashlyticsKeyParams: CrashlyticsKeyParams(
        cloudRoleInstance: AppEnv().buildType.name,
        deviceType: _deviceInfo.platform.name,
      ),
      capacity: decideLoggerBuildType<int>(
        type,
        debug: 16,
        profile: 12,
        production: 8,
      ),
    );

    filter = LoggerFilter();

    printer = LoggerPrinter(
      methodCount: decideLoggerBuildType<int>(
        type,
        debug: 6,
        profile: 4,
        production: 2,
      ),
      errorMethodCount: decideLoggerBuildType<int>(
        type,
        debug: 16,
        profile: 12,
        production: 8,
      ),
      lineLength: 80,
      printEmojis: decideLoggerBuildType<bool>(
        type,
        debug: true,
        profile: false,
        production: false,
      ),
      dateTimeFormat: decideLoggerBuildType<String Function(DateTime)>(
        type,
        debug: DateTimeFormat.onlyTimeAndSinceStart,
        profile: DateTimeFormat.onlyTimeAndSinceStart,
        production: DateTimeFormat.dateAndTime,
      ),
    );

    output = LoggerOutput(
      logServices: [console, terminal, file, crashlytics],
    );

    Future.wait([
      _deviceInfo.baseInfo,
      _deviceInfo.package,
    ]).then(
      (data) {
        final baseInfo = data[0] as BaseDeviceInfo;
        final package = data[1] as PackageInfo;

        final deviceInfo = DeviceInfoData.fromBaseDeviceInfo(
          baseInfo,
          _deviceInfo.platform,
        );
        crashlytics.updateCrashlyticsKeyParams(
          CrashlyticsKeyParams(
            //errorLevel: null,
            applicationVersion: '${package.version}+${package.buildNumber}',
            cloudRole: package.appName,
            // cloudRoleInstance: '$appFlavor ${AppEnv().buildType.name}'
            deviceModel: deviceInfo.deviceModel,
            deviceOsVersion: deviceInfo.deviceOsVersion,
            // sessionId: "",
            // userAccountId: "",
            // userAuthUserId: "",
          ),
        );
      },
    ).catchError((Object e, StackTrace stackTrace) {
      error(
        message: 'Failed to get device info',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    });

    return Logger(
      filter: filter,
      printer: printer,
      output: output,
      level: Level.all,
    );
  }
}
