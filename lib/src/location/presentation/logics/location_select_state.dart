part of 'location_select_cubit.dart';

/// State for location select
sealed class LocationSelectState extends BaseLogicState with EquatableMixin {
  const LocationSelectState();
}

/// State for location select
final class LocationSelectMessage extends LocationSelectState
    with ListenableLogicState {
  /// Type of message
  final LocationSelectMessageType messageType;

  /// Message to display
  final String? message;

  /// Flag for failure
  final bool? isFailure;

  /// Flag for success
  final bool? isSuccess;

  /// Default constructor
  const LocationSelectMessage({
    required this.messageType,
    this.message,
    this.isFailure,
    this.isSuccess,
  });

  @override
  List<Object?> get props => [ messageType, message, isFailure, isSuccess];
}

/// Location select message type
enum LocationSelectMessageType {
  /// text message
  message,
  /// disabled services
  disabledServices,
  /// permission denied
  permissionDenied,
  /// permission denied permanently
  permissionDeniedPermanently,
}

/// State for location select
final class LocationSelectIdle extends LocationSelectState
    with BuildableLogicState{
  /// Default constructor
  const LocationSelectIdle({
    required this.distance,
    required this.locationData,
    required this.zoom,
  });

  final double distance;
  final LocationData locationData;
  final double zoom;

  @override
  List<Object?> get props => [distance, locationData];
}

/// State for location select
final class LocationSelectMove extends LocationSelectState
    with ListenableLogicState{
  /// Default constructor
  const LocationSelectMove({
    required this.locationData,
    required this.zoom,
    required this.mapInitialized,
  });

  final double zoom;
  final LocationData locationData;
  final bool mapInitialized;

  @override
  List<Object?> get props => [zoom, locationData, mapInitialized];
}

/// State for location select loading
final class LocationSelectLoading extends LocationSelectState
    with ListenableLogicState {
  /// Default constructor
  const LocationSelectLoading();
  
  @override
  List<Object?> get props => ['loading'];
  
}

