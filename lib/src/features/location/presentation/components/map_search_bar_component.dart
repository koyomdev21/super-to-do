import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';

import 'package:super_to_do/src/features/location/presentation/providers/place_autocomplete_provider.dart';
import 'package:super_to_do/src/features/location/presentation/providers/map_controller_provider.dart';

class MapSearchBarComponent extends ConsumerWidget {
  MapSearchBarComponent({super.key});
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeSearchList =
        ref.watch(placeAutoCompleteStateProvider).valueOrNull ?? [];
    return Positioned(
      top: MediaQuery.of(context).size.height * .02,
      left: MediaQuery.of(context).size.width * .02,
      right: MediaQuery.of(context).size.width * .02,
      child: SafeArea(
        child: Column(
          children: [
            SearchBarFieldContent(controller: _controller),
            const SizedBox(
              height: 4,
            ),
            placeSearchList.isNotEmpty
                ? SearchBarResultContent(placeSearchList: placeSearchList)
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class SearchBarResultContent extends ConsumerWidget {
  const SearchBarResultContent({
    super.key,
    required this.placeSearchList,
  });

  final List<MapBoxPlace> placeSearchList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 14,
        ),
        itemCount: placeSearchList.length,
        itemBuilder: (ctx, index) {
          return InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                ref.read(placeAutocompleteQueryProvider.notifier).state = '';
                ref
                    .read(mapBoxControllerProvider.notifier)
                    .goToCoordinate(placeSearchList[index]);
              },
              child: ListTile(
                horizontalTitleGap: 0,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.place,
                      size: 24,
                    ),
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(placeSearchList[index].text ?? ''),
                    Text(placeSearchList[index].placeName ?? ''),
                  ],
                ),
              ));
        },
        separatorBuilder: (ctx, index) {
          return const Divider(
            height: 14,
          );
        },
      ),
    );
  }
}

class SearchBarFieldContent extends ConsumerWidget {
  const SearchBarFieldContent({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          autocorrect: false,
          autofocus: false,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(18.0),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            hintText: 'Search Places',
            suffixIcon: IconButton(
              onPressed: () async {
                _controller.clear();
                ref.read(placeAutocompleteQueryProvider.notifier).state = '';
              },
              icon: const Icon(Icons.cancel_rounded),
            ),
          ),
          onChanged: (text) {
            if (text.isNotEmpty) {
              ref.read(placeAutocompleteQueryProvider.notifier).state = text;
            } else {
              ref.read(placeAutocompleteQueryProvider.notifier).state = '';
            }
          },
        );
      },
    );
  }
}
