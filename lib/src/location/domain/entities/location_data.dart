import 'package:equatable/equatable.dart';

/// Location data
class LocationData extends Equatable{
  /// Default constructor
  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.distance,
    this.address,
  });

  /// Latitude
  final double latitude;
  /// Longitude
  final double longitude;
  /// Distance in km
  final double distance;
  /// Address
  final String? address;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    address,
    distance,
  ];

  /// Copy with
  LocationData copyWith({
    double? latitude,
    double? longitude,
    double? distance,
    String? Function()?  address,
  }) {
    return LocationData(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      distance: distance ?? this.distance,
      address: address != null ? address() : this.address,
    );
  }
}
