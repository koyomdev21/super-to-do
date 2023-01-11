import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_to_do/src/features/home/data/todo_data_source.dart';
import 'package:super_to_do/src/utils/dio_client.dart';

import '../../../utils/fake_dio_client.dart';

void main() {
  test('todoDataSource', () async {
    final container = ProviderContainer(
      overrides: [
        dioProvider.overrideWithValue(FakeAppDio()),
      ],
    );
    final todoDataSource = container.read(todoDataSourceProvider);
    await expectLater(todoDataSource.fetchTodoList(), completion(isNotNull));
  });
}
