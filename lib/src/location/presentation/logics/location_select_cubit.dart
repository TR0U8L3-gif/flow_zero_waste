import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/location/domain/entities/location_data.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

part 'location_select_state.dart';

const locationDistanceMin = 1.0;
const locationDistanceMax = 20.0;
const locationZoomMin = 8.0;
const locationZoomMax = 14.0;
const locationDefault = LocationData(
  latitude: 53.1046893,
  longitude: 23.1254141,
  distance: locationDistanceMin,
);

/// Cubit for selecting location
class LocationSelectCubit extends Cubit<LocationSelectState> {
  /// Default constructor
  LocationSelectCubit()
      : super(
          const LocationSelectIdle(
            locationData: locationDefault,
            zoom: locationZoomMax,
          ),
        );

  LocationData _locationData = locationDefault;
  bool _mapInitialized = false;

  Timer? _localizationAddressDebounce;

  /// Initialize
  Future<void> initialize(LocationData? locationData) async {
    emit(const LocationSelectLoading());
    if (locationData != null) {
      if (locationData.address != null) {
        _locationData = locationData;
        emitIdle();
      } else {
        final result = await _findMyAddress(locationData);
        _locationData = result ?? locationData;
        emitIdle();
      }
    } else {
      await findMyLocation();
    }
  }

  /// Find my location
  Future<void> findMyLocation() async {
    emit(const LocationSelectLoading());

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(
        const LocationSelectMessage(
          messageType: LocationSelectMessageType.disabledServices,
        ),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(
          const LocationSelectMessage(
            messageType: LocationSelectMessageType.permissionDenied,
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(
        const LocationSelectMessage(
          messageType: LocationSelectMessageType.permissionDeniedPermanently,
        ),
      );
      return;
    }

    final location = await Geolocator.getCurrentPosition();
    // _locationData = LocationData(
    //   latitude: location.latitude,
    //   longitude: location.longitude,
    //   distance: locationDistanceMin,
    // );
    _locationData = _locationData.copyWith(
      latitude: locationDefault.latitude,
      longitude: locationDefault.longitude,
    );
    setLocation(_locationData.latitude, _locationData.longitude);
    rebuildMap();
    emitIdle();
  }

  /// Set distance
  void setDistance(double distance) {
    if (distance > locationDistanceMax) {
      _locationData = _locationData.copyWith(distance: locationDistanceMax);
    } else if (distance < locationDistanceMin) {
      _locationData = _locationData.copyWith(distance: locationDistanceMin);
    } else {
      _locationData = _locationData.copyWith(
        distance: distance.roundToDouble(),
      );
    }
    emitIdle();
  }

  /// Rebuild map
  void rebuildMap() {
    emit(
      LocationSelectMove(
        zoom: _calculateDistanceToZoom(_locationData.distance),
        locationData: _locationData,
        mapInitialized: _mapInitialized,
      ),
    );
    emitIdle();
  }

  /// Initialize map
  void initializeMap({required bool value}) {
    _mapInitialized = value;
  }

  /// Set location
  void setLocation(double latitude, double longitude) {
    _locationData = _locationData.copyWith(
      latitude: latitude,
      longitude: longitude,
    );
    _closeTimer();
    _startTimer();
    emitIdle();
  }

  /// emit idle state
  void emitIdle() {
    if (isClosed) return;
    emit(
      LocationSelectIdle(
        locationData: _locationData,
        zoom: _calculateDistanceToZoom(_locationData.distance),
      ),
    );
  }

  double _calculateDistanceToZoom(double distance) {
    if (distance == 1) {
      return locationZoomMax;
    }
    if (distance == 2) {
      return locationZoomMax - 1;
    }
    if (distance == 3 || distance == 4) {
      return locationZoomMax - 2;
    }
    if (distance == 5 || distance == 6 || distance == 7 || distance == 8) {
      return locationZoomMax - 3;
    }
    if (distance == 9 ||
        distance == 10 ||
        distance == 11 ||
        distance == 12 ||
        distance == 13 ||
        distance == 14) {
      return locationZoomMax - 4;
    } else {
      return locationZoomMax - 5;
    }
  }

  void _closeTimer() {
    _localizationAddressDebounce?.cancel();
  }

  void _startTimer() {
    _localizationAddressDebounce = Timer(
      const Duration(seconds: 1),
      () async {
        final result = await _findMyAddress(_locationData);
        _locationData = result ?? _locationData;
        emitIdle();
        _closeTimer();
      },
    );
  }

  Future<LocationData?> _findMyAddress(LocationData location) async {
    final response = await Dio().get<Map<String, dynamic>>(
      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${_locationData.latitude}&lon=${_locationData.longitude}',
    );
    try {
      final responseData = response.data!['address'];
      final road = responseData['road'] as String;
      final houseNumber = responseData['house_number'] as String?;
      final suburb = (responseData['suburb'] as String?) ??
          responseData['state'] as String;
      final city = responseData['city'] as String;
      final postcode = responseData['postcode'] as String;
      final address = '$road ${houseNumber ?? ''}, $suburb, $postcode $city';
      return _locationData.copyWith(address: () => address);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
