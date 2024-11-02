import 'package:device_info_plus/device_info_plus.dart';
import 'package:flow_zero_waste/core/extensions/string_extension.dart';
import 'package:flow_zero_waste/core/services/device_info/device_info.dart';
import 'package:flow_zero_waste/core/services/logger_manager/logger_manager_parameters.dart';
import 'package:flow_zero_waste/core/services/setup/app_env.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:logger_manager/logger_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

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


/// LoggerManagerImplementation class
@Singleton(as: LoggerManager)
class LoggerManagerImplementation extends LoggerManager {
  /// LoggerManagerImplementation constructor
  LoggerManagerImplementation({
    required DeviceInfoManager deviceInfo,
    required LoggerManagerParameters parameters,
  })  : _deviceInfo = deviceInfo,
        _loggerManagerParameters = parameters;

  final DeviceInfoManager _deviceInfo;
  final LoggerManagerParameters _loggerManagerParameters;

  @override
  Logger build(LoggerBuildTypes type) {
    final console = ConsoleOutputService(
      canLog: true,
      buildType: type,
      logLevel: decideLoggerBuildType<Level>(
        type,
        debug: Level.all,
        profile: Level.info,
        release: Level.warning,
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
        release: Level.warning,
      ),
    );

    final file = FileOutputService(
      canLog: decideLoggerBuildType(
        type,
        debug: true,
        profile: true,
        release: true,
      ),
      fileMaxSize: decideLoggerBuildType(
        type,
        debug: 25600,
        profile: 102400,
        release: 204800,
      ),
      buildType: type,
      logLevel: Level.all,
    );

    OpenTelemetryOutputService? openTelemetry;

    if (!_loggerManagerParameters.errorHost.isNullOrEmpty &&
        !_loggerManagerParameters.errorInstrumentationKey.isNullOrEmpty) {
      openTelemetry = OpenTelemetryOutputService(
        ingestionEndpoint:
            '${_loggerManagerParameters.errorHost ?? ''}/v2/track',
        instrumentationKey:
            _loggerManagerParameters.errorInstrumentationKey ?? '',
        canLog: decideLoggerBuildType(
          type,
          debug: false,
          profile: true,
          release: true,
        ),
        logLevel: Level.all,
        buildType: type,
        telemetryContextParams: TelemetryContextParams(
          cloudRoleInstance: _loggerManagerParameters.buildType.name,
          deviceType: _deviceInfo.platform.name,
          sessionIsFirst: true,
        ),
        capacity: decideLoggerBuildType<int>(
          type,
          debug: 48,
          profile: 36,
          release: 24,
        ),
        flushDelay: Duration(
          seconds: decideLoggerBuildType<int>(
            type,
            debug: 90,
            profile: 45,
            release: 15,
          ),
        ),
      );
    }

    final crashlytics = CrashlyticsOutputService(
      canLog: decideLoggerBuildType(
        type,
        debug: false,
        profile: true,
        release: true,
      ),
      logLevel: Level.all,
      buildType: type,
      crashlyticsKeyParams: CrashlyticsKeyParams(
        cloudRoleInstance: _loggerManagerParameters.buildType.name,
        deviceType: _deviceInfo.platform.name,
      ),
      capacity: decideLoggerBuildType<int>(
        type,
        debug: 16,
        profile: 12,
        release: 8,
      ),
    );

    filter = LoggerFilter();

    printer = LoggerPrinter(
      methodCount: decideLoggerBuildType<int>(
        type,
        debug: 6,
        profile: 4,
        release: 2,
      ),
      errorMethodCount: decideLoggerBuildType<int>(
        type,
        debug: 16,
        profile: 12,
        release: 8,
      ),
      lineLength: 80,
      printEmojis: decideLoggerBuildType<bool>(
        type,
        debug: true,
        profile: false,
        release: false,
      ),
      dateTimeFormat: decideLoggerBuildType<String Function(DateTime)>(
        type,
        debug: DateTimeFormat.onlyTimeAndSinceStart,
        profile: DateTimeFormat.onlyTimeAndSinceStart,
        release: DateTimeFormat.dateAndTime,
      ),
    );

    final logServices = <LoggerOutputService>[
      console,
      terminal,
      file,
      crashlytics,
    ];

    if (openTelemetry != null) {
      logServices.add(openTelemetry);
    }

    output = LoggerOutput(
      logServices: logServices,
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
            // cloudRoleInstance: '$appFlavor '
            // '${_loggerManagerParameters.buildType.name}'
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
