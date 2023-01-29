import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:super_to_do/src/features/location/presentation/providers/location_state.dart';

final placeAutocompleteQueryProvider = StateProvider<String>((ref) {
  return '';
});

final placeAutoCompleteStateProvider =
    Provider.autoDispose<AsyncValue<List<MapBoxPlace>?>>((ref) {
  final query = ref.watch(placeAutocompleteQueryProvider);
  return ref.watch(mapboxSearchAutocompleteProvider(query));
});
