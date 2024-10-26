import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:azure_application_insights/azure_application_insights.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:logger_manager/core/helpers/fixed_sized_heap.dart';
import 'package:logger_manager/core/utils/utils.dart';
import 'package:logger_manager/logger_manager.dart';

/// OpenTelemetryOutputService
class OpenTelemetryOutputService extends LoggerOutputService {
  /// Constructor for OpenTelemetryOutputService
  OpenTelemetryOutputService({
    required super.canLog,
    required super.buildType,
    required super.logLevel,
    required this.ingestionEndpoint,
    required this.instrumentationKey,
    required this.telemetryContextParams,
    this.capacity = 24,
    this.flushDelay = const Duration(seconds: 5),
    this.timeout = const Duration(seconds: 15),
  }) {
    // Initialize telemetry client
    telemetryClient = _initializeTelemetryClient(
      processor: _initializeProcessor(capacity: capacity),
      context: _initializeTelemetryContext(params: telemetryContextParams),
    );
    // Initialize output events heap with 1/4 of capacity but not less than 4
    outputEventsHeap = FixedSizeHeap<LogEvent>(
      maxSize: max(capacity ~/ 4, 4),
      stringifyObject: stringifyLogEvent,
    );
  }

  /// Telemetry client
  late final TelemetryClient telemetryClient;

  /// Telemetry context params
  TelemetryContextParams telemetryContextParams;

  /// Events heap
  late final FixedSizeHeap<LogEvent> outputEventsHeap;

  /// Capacity of telemetry processor and heap
  final int capacity;

  /// flush delay
  final Duration flushDelay;

  /// time out duration
  final Duration timeout;

  /// instruction endpoint
  final String ingestionEndpoint;

  /// instrumentation key
  final String instrumentationKey;

  /// Initialize processor
  Processor _initializeProcessor({required int capacity}) => BufferedProcessor(
        capacity: capacity,
        flushDelay: flushDelay,
        next: DebugProcessor(
          next: TransmissionProcessor(
            ingestionEndpoint: ingestionEndpoint,
            instrumentationKey: instrumentationKey,
            httpClient: Client(),
            timeout: timeout,
          ),
        ),
      );

  /// Initialize the telemetry client
  TelemetryClient _initializeTelemetryClient({
    required Processor processor,
    required TelemetryContext context,
  }) {
    return TelemetryClient(processor: processor, context: context);
  }

  /// Initialize telemetry context
  TelemetryContext _initializeTelemetryContext({
    TelemetryContextParams? params,
  }) {
    final context = TelemetryContext()
      ..applicationVersion = params?.applicationVersion
      ..cloud.role = params?.cloudRole
      ..cloud.roleInstance = params?.cloudRoleInstance
      ..device.id = params?.deviceId
      ..device.locale = params?.deviceLocale
      ..device.model = params?.deviceModel
      ..device.oemName = params?.deviceOemName
      ..device.osVersion = params?.deviceOsVersion
      ..device.type = params?.deviceType
      ..location.city = params?.locationCity
      ..location.country = params?.locationCountry
      ..location.ip = params?.locationIp
      ..location.province = params?.locationProvince
      ..operation.correlationVector = params?.operationCorrelationVector
      ..operation.id = params?.operationId
      ..operation.name = params?.operationName
      ..operation.parentId = params?.operationParentId
      ..operation.syntheticSource = params?.operationSyntheticSource
      ..session.isFirst = params?.sessionIsFirst
      ..session.sessionId = params?.sessionSessionId
      ..user.accountId = params?.userAccountId
      ..user.authUserId = params?.userAuthUserId
      ..properties.addAll(params?.properties ?? {});

    return context;
  }

  /// Set telemetry context
  void _setTelemetryContext() {
    telemetryClient.context
      ..applicationVersion = telemetryContextParams.applicationVersion
      ..cloud.role = telemetryContextParams.cloudRole
      ..cloud.roleInstance = telemetryContextParams.cloudRoleInstance
      ..device.id = telemetryContextParams.deviceId
      ..device.locale = telemetryContextParams.deviceLocale
      ..device.model = telemetryContextParams.deviceModel
      ..device.oemName = telemetryContextParams.deviceOemName
      ..device.osVersion = telemetryContextParams.deviceOsVersion
      ..device.type = telemetryContextParams.deviceType
      ..location.city = telemetryContextParams.locationCity
      ..location.country = telemetryContextParams.locationCountry
      ..location.ip = telemetryContextParams.locationIp
      ..location.province = telemetryContextParams.locationProvince
      ..operation.correlationVector =
          telemetryContextParams.operationCorrelationVector
      ..operation.id = telemetryContextParams.operationId
      ..operation.name = telemetryContextParams.operationName
      ..operation.parentId = telemetryContextParams.operationParentId
      ..operation.syntheticSource =
          telemetryContextParams.operationSyntheticSource
      ..session.isFirst = telemetryContextParams.sessionIsFirst
      ..session.sessionId = telemetryContextParams.sessionSessionId
      ..user.accountId = telemetryContextParams.userAccountId
      ..user.authUserId = telemetryContextParams.userAuthUserId
      ..properties.addAll(telemetryContextParams.properties ?? {});
  }

  /// Update telemetry context params
  void updateTelemetryContext(TelemetryContextParams updatedParams) {
    final params = telemetryContextParams.copyWith(
      applicationVersion: updatedParams.applicationVersion,
      cloudRole: updatedParams.cloudRole,
      cloudRoleInstance: updatedParams.cloudRoleInstance,
      deviceId: updatedParams.deviceId,
      deviceLocale: updatedParams.deviceLocale,
      deviceModel: updatedParams.deviceModel,
      deviceOemName: updatedParams.deviceOemName,
      deviceOsVersion: updatedParams.deviceOsVersion,
      deviceType: updatedParams.deviceType,
      locationCity: updatedParams.locationCity,
      locationCountry: updatedParams.locationCountry,
      locationIp: updatedParams.locationIp,
      locationProvince: updatedParams.locationProvince,
      operationCorrelationVector: updatedParams.operationCorrelationVector,
      operationId: updatedParams.operationId,
      operationName: updatedParams.operationName,
      operationParentId: updatedParams.operationParentId,
      operationSyntheticSource: updatedParams.operationSyntheticSource,
      sessionIsFirst: updatedParams.sessionIsFirst,
      sessionSessionId: updatedParams.sessionSessionId,
      userAccountId: updatedParams.userAccountId,
      userAuthUserId: updatedParams.userAuthUserId,
      properties: updatedParams.properties,
    );
    telemetryContextParams = params;
  }

  /// clear telemetry context params
  void clearTelemetryContext() {
    telemetryContextParams = const TelemetryContextParams();
  }

  @override
  void log(OutputEvent event) {
    // check if can log
    if (!canLog) return;

    // check if log level is high enough
    if (event.level.index < logLevel.index) return;

    // check if telemetry context params are updated
    if (TelemetryContextParams.fromContext(telemetryClient.context) !=
        telemetryContextParams) {
      _setTelemetryContext();
    }

    // depending on build type and error level send it to telemetry processor
    // or stash it in less important logs heap
    //
    // if error is fatal or error push all logs heap to telemetry processor
    switch (buildType) {
      case LoggerBuildTypes.debug:
        // send all logs to telemetry processor
        _logToTelemetry(event.origin);
      case LoggerBuildTypes.profile:
        // send info logs and above to telemetry processor other to heap
        _logTelemetryOrHeap(event: event.origin, separator: Level.info);
      case LoggerBuildTypes.production:
        // send warning logs and above to telemetry processor other to heap
        _logTelemetryOrHeap(event: event.origin, separator: Level.warning);
    }
  }

  Future<void> _logTelemetryOrHeap({
    required LogEvent event,
    required Level separator,
  }) async {
    // send separator level and above to telemetry processor
    // other logs store in heap and send it on error level or higher
    if (event.level.index >= separator.index) {
      if (event.level.index >= Level.error.index) {
        // send all logs from heap to telemetry processor and clear heap
        // also send current dev.log to telemetry processor and flush
        await _logAllHeap();
        await _logToTelemetry(event, event.level == Level.fatal);
      } else {
        // send event to telemetry processor
        await _logToTelemetry(event);
      }
    } else {
      // store in heap
      outputEventsHeap.push(event);
    }
  }

  Future<void> _logToTelemetry(LogEvent event, [bool flush = false]) async {
    // available track methods:
    // trackError, trackRequest, trackTrace

    // unavailable track methods:
    // trackEvent, trackPageView

    final message = (event.message is LoggerMessage
        ? (event.message as LoggerMessage).message
        : event.message.toString());

    final additionalProperties = (event.message is LoggerMessage
            ? (event.message as LoggerMessage).additionalProperties
            : null) ??
        {};

    var severity = Severity.verbose;

    switch (event.level) {
      case Level.info:
        severity = Severity.information;
      case Level.warning:
        severity = Severity.warning;
      case Level.error:
        severity = Severity.error;
      case Level.fatal:
        severity = Severity.critical;
      default:
        severity = Severity.verbose;
    }

    if (event.level.index >= Level.error.index) {
      telemetryClient.trackError(
        severity: severity,
        error: event.error ?? Exception(message),
        stackTrace: event.stackTrace ?? StackTrace.current,
        timestamp: event.time.toUtc(),
        problemId: event.message is LoggerMessage
            ? (event.message as LoggerMessage).problemId
            : null,
        additionalProperties: additionalProperties,
      );
    } else {
      telemetryClient.trackTrace(
        message: message,
        severity: severity,
        timestamp: event.time.toUtc(),
        additionalProperties: additionalProperties,
      );
    }

    if (flush) {
      await telemetryClient.flush();
    }
  }

  Future<void> _logAllHeap() async {
    for (final logEvent in outputEventsHeap.heap) {
      await _logToTelemetry(logEvent);
    }
    outputEventsHeap.clearAll();
    return Future<void>.delayed(Duration.zero);
  }

  /// flush telemetry processor
  Future<void> flushAll() async {
    await _logAllHeap();
    await telemetryClient.flush();
  }
}

/// A [Processor] that logs telemetry items to the console.
class DebugProcessor implements Processor {
  /// Creates an instance of [DebugProcessor].
  DebugProcessor({
    this.next,
  });

  @override
  final Processor? next;

  /// Outputs a message detailing the telemetry being processed,
  /// then forwards the telemetry onto [next].
  @override
  void process({
    required List<ContextualTelemetryItem> contextualTelemetryItems,
  }) {
    if (!kDebugMode) {
      next?.process(
        contextualTelemetryItems: contextualTelemetryItems,
      );
      return;
    }
    final logs = [
      '| -------------------------------------- ',
      '| OpenTelemetry DebugProcessor: ',
      '| processing ${contextualTelemetryItems.length} telemetry items:',
    ];
    var i = 1;
    for (final contextualTelemetryItem in contextualTelemetryItems) {
      final json = jsonEncode(
        contextualTelemetryItem.telemetryItem
            .serialize(context: contextualTelemetryItem.context),
      );
      final data =
          '| #$i - ${contextualTelemetryItem.telemetryItem.runtimeType}: $json';
      logs.add(
        data.substring(0, min(data.length, 144)),
      );
      i++;
    }
    logs.add('| -------------------------------------- ');
    dev.log(logs.join('\n'));

    next?.process(
      contextualTelemetryItems: contextualTelemetryItems,
    );
  }

  /// Outputs a message, then forwards onto [next].
  @override
  Future<void> flush() async {
    if (kDebugMode) {
      dev.log(
        [
          ' ',
          '| -------------------------------------- ',
          '| OpenTelemetry DebugProcessor: flushing ',
          '| -------------------------------------- ',
        ].join('\n'),
      );
    }
    await next?.flush();
  }
}

@immutable

/// Telemetry context parameters
class TelemetryContextParams {
  /// Constructor for TelemetryContextParams
  const TelemetryContextParams({
    this.applicationVersion,
    this.cloudRole,
    this.cloudRoleInstance,
    this.deviceId,
    this.deviceLocale,
    this.deviceModel,
    this.deviceOemName,
    this.deviceOsVersion,
    this.deviceType,
    this.locationCity,
    this.locationCountry,
    this.locationIp,
    this.locationProvince,
    this.operationCorrelationVector,
    this.operationId,
    this.operationName,
    this.operationParentId,
    this.operationSyntheticSource,
    this.sessionIsFirst,
    this.sessionSessionId,
    this.userAccountId,
    this.userAuthUserId,
    this.properties,
  });

  /// Create a [TelemetryContextParams] from a [TelemetryContext].
  factory TelemetryContextParams.fromContext(TelemetryContext context) {
    const ignorePrefix = 'ai.';
    final propertiesEntries = <MapEntry<String, dynamic>>[];
    for (final entry in context.properties.entries) {
      if (!entry.key.startsWith(ignorePrefix)) {
        propertiesEntries.add(entry);
      }
    }
    return TelemetryContextParams(
      applicationVersion: context.applicationVersion,
      cloudRole: context.cloud.role,
      cloudRoleInstance: context.cloud.roleInstance,
      deviceId: context.device.id,
      deviceLocale: context.device.locale,
      deviceModel: context.device.model,
      deviceOemName: context.device.oemName,
      deviceOsVersion: context.device.osVersion,
      deviceType: context.device.type,
      locationCity: context.location.city,
      locationCountry: context.location.country,
      locationIp: context.location.ip,
      locationProvince: context.location.province,
      operationCorrelationVector: context.operation.correlationVector,
      operationId: context.operation.id,
      operationName: context.operation.name,
      operationParentId: context.operation.parentId,
      operationSyntheticSource: context.operation.syntheticSource,
      sessionIsFirst: context.session.isFirst,
      sessionSessionId: context.session.sessionId,
      userAccountId: context.user.accountId,
      userAuthUserId: context.user.authUserId,
      properties: Map<String, dynamic>.fromEntries(propertiesEntries),
    );
  }

  /// applicationVersion
  final String? applicationVersion;

  /// cloudRole
  final String? cloudRole;

  /// cloudRoleInstance
  final String? cloudRoleInstance;

  /// deviceId
  final String? deviceId;

  /// deviceLocale
  final String? deviceLocale;

  /// deviceModel
  final String? deviceModel;

  /// deviceOemName
  final String? deviceOemName;

  /// deviceOsVersion
  final String? deviceOsVersion;

  /// deviceType
  final String? deviceType;

  /// locationCity
  final String? locationCity;

  /// locationCountry
  final String? locationCountry;

  /// locationIp
  final String? locationIp;

  /// locationProvince
  final String? locationProvince;

  /// operationCorrelationVector
  final String? operationCorrelationVector;

  /// operationId
  final String? operationId;

  /// operationName
  final String? operationName;

  /// operationParentId
  final String? operationParentId;

  /// operationSyntheticSource
  final String? operationSyntheticSource;

  /// sessionIsFirst
  final bool? sessionIsFirst;

  /// sessionSessionId
  final String? sessionSessionId;

  /// userAccountId
  final String? userAccountId;

  /// userAuthUserId
  final String? userAuthUserId;

  /// properties
  final Map<String, dynamic>? properties;

  /// Create a new instance of [TelemetryContextParams] with updated values.
  TelemetryContextParams copyWith({
    String? applicationVersion,
    String? cloudRole,
    String? cloudRoleInstance,
    String? deviceId,
    String? deviceLocale,
    String? deviceModel,
    String? deviceOemName,
    String? deviceOsVersion,
    String? deviceType,
    String? locationCity,
    String? locationCountry,
    String? locationIp,
    String? locationProvince,
    String? operationCorrelationVector,
    String? operationId,
    String? operationName,
    String? operationParentId,
    String? operationSyntheticSource,
    bool? sessionIsFirst,
    String? sessionSessionId,
    String? userAccountId,
    String? userAuthUserId,
    Map<String, dynamic>? properties,
  }) {
    return TelemetryContextParams(
      applicationVersion: applicationVersion ?? this.applicationVersion,
      cloudRole: cloudRole ?? this.cloudRole,
      cloudRoleInstance: cloudRoleInstance ?? this.cloudRoleInstance,
      deviceId: deviceId ?? this.deviceId,
      deviceLocale: deviceLocale ?? this.deviceLocale,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceOemName: deviceOemName ?? this.deviceOemName,
      deviceOsVersion: deviceOsVersion ?? this.deviceOsVersion,
      deviceType: deviceType ?? this.deviceType,
      locationCity: locationCity ?? this.locationCity,
      locationCountry: locationCountry ?? this.locationCountry,
      locationIp: locationIp ?? this.locationIp,
      locationProvince: locationProvince ?? this.locationProvince,
      operationCorrelationVector:
          operationCorrelationVector ?? this.operationCorrelationVector,
      operationId: operationId ?? this.operationId,
      operationName: operationName ?? this.operationName,
      operationParentId: operationParentId ?? this.operationParentId,
      operationSyntheticSource:
          operationSyntheticSource ?? this.operationSyntheticSource,
      sessionIsFirst: sessionIsFirst ?? this.sessionIsFirst,
      sessionSessionId: sessionSessionId ?? this.sessionSessionId,
      userAccountId: userAccountId ?? this.userAccountId,
      userAuthUserId: userAuthUserId ?? this.userAuthUserId,
      properties: properties ?? this.properties,
    );
  }

  @override
  String toString() {
    return [
      'applicationVersion: $applicationVersion',
      'cloudRole: $cloudRole',
      'cloudRoleInstance: $cloudRoleInstance',
      'deviceId: $deviceId',
      'deviceLocale: $deviceLocale',
      'deviceModel: $deviceModel',
      'deviceOemName: $deviceOemName',
      'deviceOsVersion: $deviceOsVersion',
      'deviceType: $deviceType',
      'locationCity: $locationCity',
      'locationCountry: $locationCountry',
      'locationIp: $locationIp',
      'locationProvince: $locationProvince',
      'operationCorrelationVector: $operationCorrelationVector',
      'operationId: $operationId',
      'operationName: $operationName',
      'operationParentId: $operationParentId',
      'operationSyntheticSource: $operationSyntheticSource',
      'sessionIsFirst: $sessionIsFirst',
      'sessionSessionId: $sessionSessionId',
      'userAccountId: $userAccountId',
      'userAuthUserId: $userAuthUserId',
      'properties: $properties',
    ].join(', ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TelemetryContextParams && other.hashCode == hashCode;
  }

  @override
  int get hashCode => Object.hashAll([
        applicationVersion,
        cloudRole,
        cloudRoleInstance,
        deviceId,
        deviceLocale,
        deviceModel,
        deviceOemName,
        deviceOsVersion,
        deviceType,
        locationCity,
        locationCountry,
        locationIp,
        locationProvince,
        operationCorrelationVector,
        operationId,
        operationName,
        operationParentId,
        operationSyntheticSource,
        sessionIsFirst,
        sessionSessionId,
        userAccountId,
        userAuthUserId,
        ...properties?.keys ?? <String>[],
        ...properties?.values.map((e) => e.hashCode) ?? <dynamic>[],
      ]);
}
