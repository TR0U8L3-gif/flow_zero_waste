import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/scrollbar_styled.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/build_context_extension.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/num_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/location/domain/entities/location_data.dart';
import 'package:flow_zero_waste/src/location/presentation/logics/location_select_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const _heightSpacePercentage = 0.32;

/// Popup for selecting location
class SelectLocationPopup extends StatelessWidget {
  const SelectLocationPopup._({
    super.key,
    this.initialLocationData,
    this.onLocationSelected,
  });

  /// Show widget in bottom sheet
  static Future<T?> showBottomSheet<T>(
    BuildContext context, {
    Key? key,
    LocationData? initialLocationData,
    void Function(LocationData? data)? onLocationSelected,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectLocationPopup._(
        key: key,
        initialLocationData: initialLocationData,
        onLocationSelected: onLocationSelected,
      ),
    );
  }

  /// Initial location data
  final LocationData? initialLocationData;
  /// Callback for location selected
  final void Function(LocationData? data)? onLocationSelected;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final controller = ScrollController();

    return Padding(
      padding: EdgeInsets.only(
        top: context.mediaQuery.size.height * _heightSpacePercentage +
            context.mediaQuery.padding.top,
        bottom: context.mediaQuery.padding.bottom,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: page.layoutSize >= PageLayoutSize.expanded
              ? AppSize.layoutMedium.max
              : double.infinity,
          child: ClipRRect(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(page.spacing)),
            child: Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(page.spacingHalf),
                    child: Container(
                      width: AppSize.xxxl88,
                      height: page.spacingQuarter,
                      decoration: BoxDecoration(
                        color: context.colorScheme.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(page.spacing),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ScrollbarStyled(
                      controller: controller,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: page.spacing),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            page.spacing,
                          ),
                          child: Align(
                            child: SingleChildScrollView(
                              controller: controller,
                              child: _SelectLocation(
                                initialLocationData,
                                onLocationSelected,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectLocation extends StatelessWidget {
  const _SelectLocation(this.initialLocationData, this.onLocationSelected);

  final LocationData? initialLocationData;
  final void Function(LocationData? data)? onLocationSelected;

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    final page = context.watch<PageProvider>();
    return BlocProvider(
      create: (context) =>
          LocationSelectCubit()..initialize(initialLocationData),
      child: BlocConsumer<LocationSelectCubit, LocationSelectState>(
        listener: (context, state) {
          if (!state.isListenable) return;
          if (state is LocationSelectMove) {
            if (!state.mapInitialized) return;
            final lat = state.locationData.latitude;
            final lng = state.locationData.longitude;
            final zoom = state.zoom;
            mapController.move(LatLng(lat, lng), zoom);
          }
        },
        builder: (context, state) {
          final cubit = context.read<LocationSelectCubit>();
          if (state is LocationSelectIdle) {
            final lat = state.locationData.latitude;
            final lng = state.locationData.longitude;
            final zoom = state.zoom;
            final address = state.locationData.address;
            final distance = state.locationData.distance;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                Text(
                  context.l10n.checkAvailabilityInYourArea,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                if (address != null)
                  Text(
                    address,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: page.spacing),
                // Map placeholder
                AspectRatio(
                  aspectRatio: 16 / 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(page.spacing),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              initialCenter: LatLng(lat, lng),
                              initialZoom: zoom,
                              interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.drag 
                                | InteractiveFlag.pinchZoom
                                | InteractiveFlag.doubleTapZoom,
                              ),
                              backgroundColor: context.colorScheme.secondary,
                              onPointerUp: (point, position) =>
                                  cubit.setLocation(
                                position.latitude,
                                position.longitude,
                              ),
                              onMapReady: () {
                                cubit.initializeMap(value: true);
                                mapController.move(LatLng(lat, lng), zoom);
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              ),
                              CircleLayer(
                                circles: [
                                  CircleMarker(
                                    point: () {
                                      try {
                                        return mapController.camera.center;
                                      } catch (e) {
                                        return LatLng(lat, lng);
                                      }
                                    }(),
                                    useRadiusInMeter: true,
                                    color: context.colorScheme.onPrimary
                                        .withOpacity(AppSize.xxl.fraction),
                                    radius: distance * 1000,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.location_on,
                            color: context.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSize.l),
                // Distance slider
                Column(
                  children: [
                    Text(
                      context.l10n.selectDistance,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Slider(
                      value: distance,
                      min: 1,
                      max: 20,
                      divisions: 20,
                      label: '${distance.toStringAsFixed(0)} km',
                      onChanged: cubit.setDistance,
                      onChangeEnd: (value) => cubit.rebuildMap(),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s),
                // Use current location
                TextButton.icon(
                  onPressed: cubit.findMyLocation,
                  icon: const Icon(Icons.my_location_rounded),
                  label: Text(context.l10n.useMyCurrentLocation),
                ),
                const SizedBox(height: AppSize.s),
                // Apply button
                ElevatedButton(
                  onPressed: () {
                    onLocationSelected?.call(state.locationData);
                    Navigator.of(context).pop();
                  },
                  child: Text(context.l10n.apply),
                ),
                const SizedBox(
                  height: AppSize.xl,
                ),
              ],
            );
          } else {
            cubit.initializeMap(value: false);
            return const Align(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
