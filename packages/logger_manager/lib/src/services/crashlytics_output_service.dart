import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:logger_manager/core/helpers/fixed_sized_heap.dart';
import 'package:logger_manager/logger_manager.dart';

/// CrashlyticsOutputService class
class CrashlyticsOutputService extends LoggerOutputService {
  /// Constructor for CrashlyticsOutputService
  CrashlyticsOutputService({
    required super.canLog,
    required super.buildType,
    required super.logLevel,
    required CrashlyticsKeyParams crashlyticsKeyParams,
    this.capacity = 8,
  }) : _crashlyticsKeyParams = crashlyticsKeyParams {
    _heap = FixedSizeHeap<LogEvent>(maxSize: capacity);
  }

  /// Is Crashlytics collection enabled, depends on canLog
  bool _isCrashlyticsCollectionEnabled = true;

  /// Capacity of the heap
  final int capacity;

  /// Crashlytics Key Params
  CrashlyticsKeyParams _crashlyticsKeyParams;

  /// Previous Crashlytics Key Params
  CrashlyticsKeyParams _previousCrashlyticsKeyParams =
      const CrashlyticsKeyParams();

  /// Events heap
  late final FixedSizeHeap<LogEvent> _heap;

  /// getter for isCrashlyticsCollectionEnabled
  bool get isCrashlyticsCollectionEnabled => _isCrashlyticsCollectionEnabled;

  /// getter for Crashlytics Key Params
  CrashlyticsKeyParams get crashlyticsKeyParams => _crashlyticsKeyParams;

  /// getter for output events heap
  List<LogEvent> get outputEventsHeap => _heap.heap;

  /// if hash code is different, update custom keys in Crashlytics
  Future<void> _checkForCustomKeyUpdate() async {
    // if hash code is the same, return
    if (_crashlyticsKeyParams == _previousCrashlyticsKeyParams) return;

    // update custom keys in Crashlytics
    for (var i = 0; i < _crashlyticsKeyParams.map.length; i++) {
      final entry = _crashlyticsKeyParams.map.entries.toList()[i];
      final previousEntry =
          _previousCrashlyticsKeyParams.map.entries.toList()[i];
      // if value is the same, continue
      if (entry.value == previousEntry.value) {
        continue;
      }
      // if value is null, continue
      if (entry.value == null) {
        continue;
      }
      // set custom key in Crashlytics
      await FirebaseCrashlytics.instance.setCustomKey(
        entry.key,
        entry.value!,
      );
      // if key is userAccountId, set setUserIdentifier in Crashlytics
      if (entry.key == 'user_account_id' && entry.value != null) {
        await FirebaseCrashlytics.instance.setUserIdentifier('${entry.value}');
      }
    }

    // update previous Crashlytics Key Params
    _previousCrashlyticsKeyParams = _crashlyticsKeyParams;
  }

  Future<void> _logCrashlyticsOrHeap({
    required LogEvent event,
    required Level separator,
  }) async {
    // send separator level and above to crashlytics
    // other logs store in heap and send it on error level or higher
    if (event.level.index >= separator.index) {
      if (event.level.index >= Level.error.index) {
        // send all logs from heap to crashlytics and clear heap
        await _logAllHeap();
      }
      // send event to crashlytics
      await _logToCrashlytics(event);
    } else {
      // store in heap
      _heap.push(event);
    }
  }

  Future<void> _logToCrashlytics(LogEvent event) async {
    final message = (event.message is LoggerMessage
        ? (event.message as LoggerMessage).message
        : event.message.toString());

    await FirebaseCrashlytics.instance.recordError(
      event.error ?? Exception(message),
      event.stackTrace ?? StackTrace.current,
      reason: message,
      information: [
        if (event.message is LoggerMessage)
          'problemId: ${(event.message as LoggerMessage).problemId}',
      ],
      fatal: event.level.index >= Level.error.index,
      printDetails: false,
    );
  }

  Future<void> _logAllHeap() async {
    for (final logEvent in _heap.heap) {
      await _logToCrashlytics(logEvent);
    }
    _heap.clearAll();
    return Future<void>.delayed(Duration.zero);
  }

  @override
  void log(OutputEvent event) {
    // check if can log
    if (!canLog) {
      _isCrashlyticsCollectionEnabled = false;
      if (_isCrashlyticsCollectionEnabled) {
        Future.wait([
          FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false),
        ]);
      }
      return;
    }

    // check if log level high enough
    if (event.level.index < logLevel.index) return;

    // set new event level
    updateCrashlyticsKeyParams(
      CrashlyticsKeyParams(errorLevel: event.level.name),
    );

    // check if Crashlytics custom key need update
    _checkForCustomKeyUpdate();

    // depending on build type and error level send it to crashlytics
    // or stash it in less important logs heap
    //
    // if error is fatal or error push all logs heap to crashlytics
    switch (buildType) {
      case LoggerBuildTypes.debug:
        // send all logs to crashlytics
        _logToCrashlytics(event.origin);
      case LoggerBuildTypes.profile:
        // send info logs and above to crashlytics other to heap
        _logCrashlyticsOrHeap(event: event.origin, separator: Level.info);
      case LoggerBuildTypes.release:
        // send warning logs and above to crashlytics other to heap
        _logCrashlyticsOrHeap(event: event.origin, separator: Level.warning);
    }
  }

  /// Update Crashlytics Key Params
  void updateCrashlyticsKeyParams(CrashlyticsKeyParams crashlyticsKeyParams) {
    _crashlyticsKeyParams = _crashlyticsKeyParams.copyWith(
      errorLevel: crashlyticsKeyParams.errorLevel,
      applicationVersion: crashlyticsKeyParams.applicationVersion,
      cloudRole: crashlyticsKeyParams.cloudRole,
      cloudRoleInstance: crashlyticsKeyParams.cloudRoleInstance,
      deviceModel: crashlyticsKeyParams.deviceModel,
      deviceOsVersion: crashlyticsKeyParams.deviceOsVersion,
      deviceType: crashlyticsKeyParams.deviceType,
      sessionId: crashlyticsKeyParams.sessionId,
      userAccountId: crashlyticsKeyParams.userAccountId,
      userAuthUserId: crashlyticsKeyParams.userAuthUserId,
    );
    _checkForCustomKeyUpdate();
  }

  /// clear heap data
  void clearHeapData() {
    _heap.clearAll();
  }

  /// flush heap data
  void flushHeapData() {
    _logAllHeap();
  }
}

@immutable

/// Crashlytics Key Params
class CrashlyticsKeyParams {
  /// Constructor for CrashlyticsKeyParams
  const CrashlyticsKeyParams({
    this.errorLevel,
    this.applicationVersion,
    this.cloudRole,
    this.cloudRoleInstance,
    this.deviceModel,
    this.deviceOsVersion,
    this.deviceType,
    this.sessionId,
    this.userAccountId,
    this.userAuthUserId,
  });

  /// errorLevel
  final String? errorLevel;

  /// applicationVersion
  final String? applicationVersion;

  /// cloudRole
  final String? cloudRole;

  /// cloudRoleInstance
  final String? cloudRoleInstance;

  /// deviceModel
  final String? deviceModel;

  /// deviceOsVersion
  final String? deviceOsVersion;

  /// deviceType
  final String? deviceType;

  /// sessionId
  final String? sessionId;

  /// userAccountId
  final String? userAccountId;

  /// userAuthUserId
  final String? userAuthUserId;

  /// Create a new instance of [CrashlyticsKeyParams] with updated values
  CrashlyticsKeyParams copyWith({
    String? errorLevel,
    String? applicationVersion,
    String? cloudRole,
    String? cloudRoleInstance,
    String? deviceModel,
    String? deviceOsVersion,
    String? deviceType,
    String? sessionId,
    String? userAccountId,
    String? userAuthUserId,
  }) {
    return CrashlyticsKeyParams(
      errorLevel: errorLevel ?? this.errorLevel,
      applicationVersion: applicationVersion ?? this.applicationVersion,
      cloudRole: cloudRole ?? this.cloudRole,
      cloudRoleInstance: cloudRoleInstance ?? this.cloudRoleInstance,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceOsVersion: deviceOsVersion ?? this.deviceOsVersion,
      deviceType: deviceType ?? this.deviceType,
      sessionId: sessionId ?? this.sessionId,
      userAccountId: userAccountId ?? this.userAccountId,
      userAuthUserId: userAuthUserId ?? this.userAuthUserId,
    );
  }

  /// Create map from CrashlyticsKeyParams
  Map<String, String?> get map => {
        'error_level': errorLevel,
        'application_version': applicationVersion,
        'cloud_role': cloudRole,
        'cloud_role_instance': cloudRoleInstance,
        'device_model': deviceModel,
        'device_os_version': deviceOsVersion,
        'device_type': deviceType,
        'session_id': sessionId,
        'user_account_id': userAccountId,
        'user_auth_user_id': userAuthUserId,
      };

  @override
  String toString() {
    return [
      'errorLevel: $errorLevel',
      'applicationVersion: $applicationVersion',
      'cloudRole: $cloudRole',
      'cloudRoleInstance: $cloudRoleInstance',
      'deviceModel: $deviceModel',
      'deviceOsVersion: $deviceOsVersion',
      'deviceType: $deviceType',
      'sessionId: $sessionId',
      'userAccountId: $userAccountId',
      'userAuthUserId: $userAuthUserId',
    ].join(', ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CrashlyticsKeyParams &&
        other.errorLevel == errorLevel &&
        other.applicationVersion == applicationVersion &&
        other.cloudRole == cloudRole &&
        other.cloudRoleInstance == cloudRoleInstance &&
        other.deviceModel == deviceModel &&
        other.deviceOsVersion == deviceOsVersion &&
        other.deviceType == deviceType &&
        other.sessionId == sessionId &&
        other.userAccountId == userAccountId &&
        other.userAuthUserId == userAuthUserId;
  }

  @override
  int get hashCode => Object.hashAll([
        errorLevel,
        applicationVersion,
        cloudRole,
        cloudRoleInstance,
        deviceModel,
        deviceOsVersion,
        deviceType,
        sessionId,
        userAccountId,
        userAuthUserId,
      ]);
}
