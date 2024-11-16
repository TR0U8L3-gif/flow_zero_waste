import 'package:equatable/equatable.dart';

class LocationData extends Equatable{
  const LocationData({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  final double latitude;
  final double longitude;
  final String? address;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    address,
  ];
}
