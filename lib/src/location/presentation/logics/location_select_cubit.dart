import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/location/domain/entities/location_data.dart';
import 'package:geolocator/geolocator.dart';

part 'location_select_state.dart';

const locationDistanceMin = 1.0;
const locationDistanceMax = 20.0;
const locationZoomMin = 8.0;
const locationZoomMax = 14.0;
const locationDefault = LocationData(
  latitude: 53.1045529,
  longitude: 23.1230006,
);

/// Cubit for selecting location
class LocationSelectCubit extends Cubit<LocationSelectState> {
  /// Default constructor
  LocationSelectCubit()
      : super(
          const LocationSelectIdle(
            distance: locationDistanceMin,
            locationData: locationDefault,
            zoom: locationZoomMax,
          ),
        );

  LocationData _locationData = locationDefault;
  double _distance = locationDistanceMin;
  bool _mapInitialized = false;

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
    _locationData = LocationData(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    rebuildMap();
    emitIdle();
  }

  /// Set distance
  void setDistance(double distance) {
    if (distance > locationDistanceMax) {
      _distance = locationDistanceMax;
    } else if (distance < locationDistanceMin) {
      _distance = locationDistanceMin;
    }
    _distance = distance.roundToDouble();
    emitIdle();
  }

  /// Rebuild map
  void rebuildMap() {
    emit(
      LocationSelectMove(
        zoom: _calculateDistanceToZoom(_distance),
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
    _locationData = LocationData(latitude: latitude, longitude: longitude);
    emitIdle();
  }

  /// emit idle state
  void emitIdle() {
    emit(
      LocationSelectIdle(
        distance: _distance,
        locationData: _locationData,
        zoom: _calculateDistanceToZoom(_distance),
      ),
    );
  }

  double _calculateDistanceToZoom(double distance) {
    if(distance == 1) {
      return locationZoomMax;
    }
    if(distance == 2 ) {
      return locationZoomMax - 1;
    }
    if( distance == 3 ||distance == 4 ) {
      return locationZoomMax - 2;
    }
    if(distance == 5 || distance == 6 || distance == 7 || distance == 8) {
      return locationZoomMax - 3;
    }
    if(distance == 9 || distance == 10 || distance == 11 || distance == 12 || distance == 13 || distance == 14) {
      return locationZoomMax - 4;
    }
    else {
      return locationZoomMax - 5;
    } 
    
  }
}
