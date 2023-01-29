import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';

class MapBoxSearchAutoComplete {
  Future<List<MapBoxPlace>?> placesSearch(String query) async {
    // uncomment below to demonstrate caching
    // await Future.delayed(const Duration(seconds: 5));
    var placesService = PlacesSearch(
      apiKey: dotenv.get('MAPBOX_ACCESS_TOKEN'),
      limit: 5,
    );
    Future.delayed(const Duration(seconds: 10));

    var places = await placesService.getPlaces(
      query,
    );

    return places;
  }
}

final mapboxSearchAutocompleteProvider =
    FutureProvider.autoDispose.family<List<MapBoxPlace>?, String>((ref, query) {
  final link = ref.keepAlive();
  // * keep previous search results in memory for 60 seconds
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  final places = MapBoxSearchAutoComplete().placesSearch(query);
  return places;
});
