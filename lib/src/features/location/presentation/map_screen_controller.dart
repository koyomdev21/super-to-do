import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_repository/location_repository.dart';

class MapScreenControllerNotifier
    extends StateNotifier<AsyncValue<CurrentUserLocationEntity>> {
  MapScreenControllerNotifier(
    this.ref,
  ) : super(const AsyncData(CurrentUserLocationEntity.empty)) {
    getLocationEvent();
  }

  final Ref ref;

  void getLocationEvent() async {
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
        () => ref.read(locationRepositoryProvider).getCurrentLocation());
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData(value.value ?? CurrentUserLocationEntity.empty);
    }
  }
}

final mapScreenControllerProvider = StateNotifierProvider.autoDispose<
    MapScreenControllerNotifier, AsyncValue<CurrentUserLocationEntity>>((ref) {
  return MapScreenControllerNotifier(ref);
});
