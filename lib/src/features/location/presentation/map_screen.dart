import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_repository/location_repository.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:super_to_do/src/common_widgets/async_value_widget.dart';
import 'package:super_to_do/src/utils/async_value_ui.dart';

import '../../../common_widgets/info_card_widget.dart';
import '../../../common_widgets/zoom_in_out_widget.dart';
import 'map_screen_controller.dart';

class MapScreen extends ConsumerWidget {
  MapScreen({
    this.mapController,
  });

  MapboxMapController? mapController;

  _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      mapScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final currentUserLocation = ref.watch(mapScreenControllerProvider);
    return Scaffold(
      body: AsyncValueWidget<CurrentUserLocationEntity>(
        value: currentUserLocation,
        data: (userLocation) => Stack(
          children: [
            MapboxMap(
              accessToken: dotenv.get('MAPBOX_ACCESS_TOKEN'),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              trackCameraPosition: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  userLocation.latitude,
                  userLocation.longitude,
                ),
                zoom: 9.0,
              ),
              onMapClick: (_, latlng) async {
                await mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      bearing: 10.0,
                      target: LatLng(
                        latlng.latitude,
                        latlng.longitude,
                      ),
                      tilt: 30.0,
                      zoom: 12.0,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              child: InfoCardWidget(
                currentUserLocation: userLocation,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .18,
              right: 10,
              child: ZoomInOutWidget(
                zoomInCallback: () async => await mapController?.animateCamera(
                  CameraUpdate.zoomIn(),
                ),
                zoomOutCallback: () async => await mapController?.animateCamera(
                  CameraUpdate.zoomOut(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
