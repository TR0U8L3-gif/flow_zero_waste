import 'dart:convert';

import 'package:flow_zero_waste/src/location/data/datasources/location_hive_storage.dart';
import 'package:flow_zero_waste/src/location/domain/entities/location_data.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger_manager/logger_manager.dart';

const _key = 'locationData';

/// Provider for location data
@injectable
class LocationProvider extends ChangeNotifier {
  /// Default constructor
  LocationProvider({
    required LoggerManager loggerManager,
    required LocationStorageHive locationStorageHive,
  })  : _loggerManager = loggerManager,
        _locationStorageHive = locationStorageHive {
    loadLocationData();
  }

  final LoggerManager _loggerManager;
  final LocationStorageHive _locationStorageHive;

  /// Location data
  LocationData? _locationData;

  /// Flag for initialization status
  bool _isInitialized = false;

  /// Getter for location data
  LocationData? get locationData => _locationData;

  /// Getter for initialization status
  bool get isInitialized => _isInitialized;

  /// Load location data
  Future<void> loadLocationData() async {
    try {
      _loggerManager.trace(message: 'Loading location data');
      final data = await _locationStorageHive.read(key: _key);
      if (data != null) {
        final jsonData = json.decode(data) as Map<String, dynamic>;
        _locationData = LocationData(
          latitude: jsonData['latitude'] as double,
          longitude: jsonData['longitude'] as double,
          distance: jsonData['distance'] as double,
          address: jsonData['address'] as String,
        );
      }
      _loggerManager.trace(message: 'Location data loaded: $_locationData');
      _isInitialized = true;
      notifyListeners();
    } catch (e, st) {
      _loggerManager.error(
          message: 'Error loading location data: $e', stackTrace: st,);
    }
  }

  /// Save location data
  void saveLocationData(LocationData? locationData) {
    if (locationData == null) {
      return;
    }
    _locationData = locationData;
    _isInitialized = true;
    notifyListeners();
    _loggerManager.trace(message: 'Saving location data: $locationData');
    final jsonData = <String, dynamic>{
      'latitude': locationData.latitude,
      'longitude': locationData.longitude,
      'distance': locationData.distance,
      'address': locationData.address,
    };
    final data = json.encode(jsonData);
    _locationStorageHive.write(data, key: _key);
    _loggerManager.trace(message: 'Location data saved');
  }
}
