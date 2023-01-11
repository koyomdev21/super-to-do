import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_to_do/src/features/home/data/todo_data_source.dart';
import 'package:super_to_do/src/features/home/data/todo_repository.dart';

import '../../../../mocks.dart';

void main() {
  late MockToDoDataSource toDoDataSource;

  setUp(() {
    toDoDataSource = MockToDoDataSource();
  });

  ToDoRepository makeToDoRepository() {
    final container = ProviderContainer(
      overrides: [
        todoDataSourceProvider.overrideWithValue(toDoDataSource),
      ],
    );
    addTearDown(container.dispose);
    return container.read(todoRepositoryProvider);
  }

  group('todo repository', () {
    // test('repository return todo list', () async {
    //   // setup
    //   when(toDoDataSource.fetchTodoList)
    //       .thenAnswer((_) => Future.value(dummyToDoList));
    //   final todoRepository = makeToDoRepository();
    //   // run
    //   final todoList = await todoRepository.fetchToDoList();
    //   // verify
    //   expect(todoList, isNotNull);
    // });
  });
}
