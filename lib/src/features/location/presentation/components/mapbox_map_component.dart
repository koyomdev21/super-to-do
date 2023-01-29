import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';

import 'package:super_to_do/src/features/location/presentation/providers/map_controller_provider.dart';
import 'package:location_repository/location_repository.dart';

class MapBoxMapComponent extends ConsumerWidget {
  const MapBoxMapComponent({super.key, required this.currentUserLocation});
  final CurrentUserLocationEntity currentUserLocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<MapboxMapController?>(
      mapBoxControllerProvider,
      (previous, next) {},
    );
    return MapboxMap(
      accessToken: dotenv.get('MAPBOX_ACCESS_TOKEN'),
      myLocationEnabled: true,
      trackCameraPosition: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          currentUserLocation.latitude,
          currentUserLocation.longitude,
        ),
        zoom: 9.0,
      ),
      onMapClick: (_, latlng) {
        ref.read(mapBoxControllerProvider.notifier).mapOnClick(latlng);
      },
      onMapCreated: (controller) async {
        print('controller assignet on created');
        ref.read(currentMapControllerProvider.notifier).state = controller;
      },
    );
  }
}
