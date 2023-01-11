import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:super_to_do/src/features/home/domain/todo_response.dart';

import '../data/todo_repository.dart';

class HomeScreenControllerNotifier
    extends StateNotifier<AsyncValue<ToDoResponse>> {
  HomeScreenControllerNotifier(
    this.ref,
  ) : super(AsyncData(ToDoResponse(data: ToDoDataResponse(todos: [])))) {
    fetchToDoList();
  }
  final Ref ref;

  Future<void> fetchToDoList() async {
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
        () => ref.read(todoRepositoryProvider).fetchToDoList());
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData(value.value!);
    }
  }
}

final homeScreenControllerProvider = StateNotifierProvider.autoDispose<
    HomeScreenControllerNotifier, AsyncValue<ToDoResponse>>((ref) {
  ref.onDispose(() {
    print('homecontroller disposed');
  });
  final link = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  return HomeScreenControllerNotifier(ref);
});
