import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_to_do/src/features/home/domain/todo_response.dart';

import 'todo_data_source.dart';

class ToDoRepository {
  ToDoRepository(this.ref);
  final Ref ref;

  Future<ToDoResponse> fetchToDoList() async {
    final todoDataSource = ref.watch(todoDataSourceProvider);
    final result = await todoDataSource.fetchTodoList();
    return Future.value(result);
  }
}

final todoRepositoryProvider = Provider.autoDispose<ToDoRepository>((ref) {
  ref.onDispose(() {
    print('todoRepository disposed');
  });
  return ToDoRepository(ref);
});
