// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:location_repository/location_repository.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

// import 'package:super_to_do/src/common_widgets/async_value_widget.dart';
// import 'package:super_to_do/src/features/location/presentation/providers/place_autocomplete_provider.dart';
// import 'package:super_to_do/src/utils/async_value_ui.dart';

// import '../../../common_widgets/info_card_widget.dart';
// import '../../../common_widgets/zoom_in_out_widget.dart';
// import 'providers/map_screen_controller.dart';

// class MapScreen extends ConsumerStatefulWidget {
//   const MapScreen({super.key});

//   @override
//   ConsumerState<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends ConsumerState<MapScreen> {
//   MapboxMapController? mapController;
//   final _controller = TextEditingController();

//   _onMapCreated(MapboxMapController controller) async {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     ref.listen<AsyncValue>(
//       mapScreenControllerProvider,
//       (_, state) => state.showAlertDialogOnError(context),
//     );
//     final currentUserLocation = ref.watch(mapScreenControllerProvider);
//     return Scaffold(
//       body: AsyncValueWidget<CurrentUserLocationEntity>(
//         value: currentUserLocation,
//         data: (userLocation) => Stack(
//           children: [
//             MapboxMap(
//               accessToken: dotenv.get('MAPBOX_ACCESS_TOKEN'),
//               onMapCreated: _onMapCreated,
//               myLocationEnabled: true,
//               trackCameraPosition: true,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   userLocation.latitude,
//                   userLocation.longitude,
//                 ),
//                 zoom: 9.0,
//               ),
//               onMapClick: (_, latlng) async {
//                 await mapController?.animateCamera(
//                   CameraUpdate.newCameraPosition(
//                     CameraPosition(
//                       bearing: 10.0,
//                       target: LatLng(
//                         latlng.latitude,
//                         latlng.longitude,
//                       ),
//                       tilt: 30.0,
//                       zoom: 12.0,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Consumer(
//               builder: (context, ref, child) {
//                 final placeSearchList =
//                     ref.watch(placeAutoCompleteStateProvider).valueOrNull ?? [];
//                 return Positioned(
//                   top: MediaQuery.of(context).size.height * .02,
//                   left: MediaQuery.of(context).size.width * .02,
//                   right: MediaQuery.of(context).size.width * .02,
//                   child: SafeArea(
//                     child: Column(
//                       children: [
//                         ValueListenableBuilder<TextEditingValue>(
//                           valueListenable: _controller,
//                           builder: (context, value, _) {
//                             return TextField(
//                               autocorrect: false,
//                               autofocus: false,
//                               style: Theme.of(context).textTheme.titleLarge,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 contentPadding: const EdgeInsets.all(18.0),
//                                 border: const OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(30),
//                                   ),
//                                 ),
//                                 hintText: 'Search Places',
//                                 suffixIcon: IconButton(
//                                   onPressed: () async {
//                                     _controller.clear();
//                                     ref
//                                         .read(placeAutocompleteQueryProvider
//                                             .notifier)
//                                         .state = '';
//                                   },
//                                   icon: const Icon(Icons.cancel_rounded),
//                                 ),
//                               ),
//                               onChanged: (text) {
//                                 if (text.isNotEmpty) {
//                                   ref
//                                       .read(placeAutocompleteQueryProvider
//                                           .notifier)
//                                       .state = text;
//                                 } else {
//                                   ref
//                                       .read(placeAutocompleteQueryProvider
//                                           .notifier)
//                                       .state = '';
//                                 }
//                               },
//                             );
//                           },
//                         ),
//                         const SizedBox(
//                           height: 4,
//                         ),
//                         placeSearchList.isNotEmpty
//                             ? Card(
//                                 margin: EdgeInsets.zero,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: ListView.separated(
//                                   shrinkWrap: true,
//                                   physics: const ClampingScrollPhysics(),
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 4,
//                                     horizontal: 14,
//                                   ),
//                                   itemCount: placeSearchList.length,
//                                   itemBuilder: (ctx, index) {
//                                     return InkWell(
//                                         borderRadius: BorderRadius.circular(8),
//                                         onTap: () async {
//                                           ref
//                                               .read(
//                                                   placeAutocompleteQueryProvider
//                                                       .notifier)
//                                               .state = '';
//                                           await mapController?.animateCamera(
//                                             CameraUpdate.newCameraPosition(
//                                               CameraPosition(
//                                                 bearing: 10.0,
//                                                 target: LatLng(
//                                                   placeSearchList[index]
//                                                           .geometry
//                                                           ?.coordinates
//                                                           ?.last ??
//                                                       0.0,
//                                                   placeSearchList[index]
//                                                           .geometry
//                                                           ?.coordinates
//                                                           ?.first ??
//                                                       0.0,
//                                                 ),
//                                                 tilt: 30.0,
//                                                 zoom: 12.0,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         child: ListTile(
//                                           horizontalTitleGap: 0,
//                                           leading: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: const [
//                                               Icon(
//                                                 Icons.place,
//                                                 size: 24,
//                                               ),
//                                             ],
//                                           ),
//                                           title: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                   placeSearchList[index].text ??
//                                                       ''),
//                                               Text(placeSearchList[index]
//                                                       .placeName ??
//                                                   ''),
//                                             ],
//                                           ),
//                                         ));
//                                   },
//                                   separatorBuilder: (ctx, index) {
//                                     return const Divider(
//                                       height: 14,
//                                     );
//                                   },
//                                 ),
//                               )
//                             : const SizedBox()
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Positioned(
//               bottom: 0,
//               child: InfoCardWidget(
//                 currentUserLocation: userLocation,
//               ),
//             ),
//             Positioned(
//               bottom: MediaQuery.of(context).size.height * .18,
//               right: 10,
//               child: ZoomInOutWidget(
//                 zoomInCallback: () async => await mapController?.animateCamera(
//                   CameraUpdate.zoomIn(),
//                 ),
//                 zoomOutCallback: () async => await mapController?.animateCamera(
//                   CameraUpdate.zoomOut(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         onPressed: () {
//           ref.invalidate(mapScreenControllerProvider);
//         },
//       ),
//     );
//   }
// }
