import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:super_to_do/src/features/location/presentation/components/info_card_widget_component.dart';
import 'package:super_to_do/src/features/location/presentation/components/zoom_in_out_widget_component.dart';
import 'package:super_to_do/src/features/location/presentation/providers/map_controller_provider.dart';
import 'package:super_to_do/src/features/location/presentation/components/retry_again_component.dart';
import 'package:super_to_do/src/features/location/presentation/components/mapbox_map_component.dart';
import 'package:super_to_do/src/features/location/presentation/components/map_search_bar_component.dart';
import 'package:super_to_do/src/features/location/presentation/providers/map_screen_controller.dart';
import 'package:location_repository/location_repository.dart';
import 'package:super_to_do/src/utils/async_value_ui.dart';

class MapScreenBase extends ConsumerWidget {
  const MapScreenBase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      mapScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final currentUserLocation = ref.watch(mapScreenControllerProvider);
    return Scaffold(
      body: currentUserLocation.when(
        data: (currentLocation) => Stack(
          children: [
            MapBoxMapComponent(currentUserLocation: currentLocation),
            MapSearchBarComponent(),
            InfoCardWidgetComponent(currentUserLocation: currentLocation),
            ZoomInOutWidgetComponent(
              zoomInCallback: () =>
                  ref.read(mapBoxControllerProvider.notifier).zoomIn(),
              zoomOutCallback: () =>
                  ref.read(mapBoxControllerProvider.notifier).zoomOut(),
            ),
          ],
        ),
        error: (e, st) {
          var mye = e as CurrentLocationFailure;
          return RetryAgainComponent(
            description: mye.error,
            onPressed: () => ref.invalidate(mapScreenControllerProvider),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
