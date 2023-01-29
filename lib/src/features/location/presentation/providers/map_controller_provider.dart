import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_search/mapbox_search.dart';

final currentMapControllerProvider =
    StateProvider.autoDispose<MapboxMapController?>((ref) {
  return null;
});

final mapBoxControllerProvider = NotifierProvider.autoDispose<
    MapBoxControllerNotifier,
    MapboxMapController?>(MapBoxControllerNotifier.new);

class MapBoxControllerNotifier
    extends AutoDisposeNotifier<MapboxMapController?> {
  @override
  MapboxMapController? build() {
    state = ref.watch(currentMapControllerProvider);
    return state;
  }

  void mapOnClick(LatLng latLng) {
    state?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 10.0,
          target: LatLng(
            latLng.latitude,
            latLng.longitude,
          ),
          tilt: 30.0,
          zoom: 12.0,
        ),
      ),
    );
  }

  void goToCoordinate(MapBoxPlace mapBoxPlace) {
    state?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 10.0,
          target: LatLng(
            mapBoxPlace.geometry?.coordinates?.last ?? 0.0,
            mapBoxPlace.geometry?.coordinates?.first ?? 0.0,
          ),
          tilt: 30.0,
          zoom: 12.0,
        ),
      ),
    );
  }

  void zoomIn() {
    state?.animateCamera(
      CameraUpdate.zoomIn(),
    );
  }

  void zoomOut() {
    state?.animateCamera(
      CameraUpdate.zoomIn(),
    );
  }
}
