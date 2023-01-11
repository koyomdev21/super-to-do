import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_to_do/src/features/home/domain/todo_response.dart';
import 'package:super_to_do/src/features/home/presentation/todo_card.dart';

import '../../../common_widgets/async_value_widget.dart';
import '../../../common_widgets/responsive_center.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/breakpoints.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key, required this.todos});
  final AsyncValue<ToDoResponse> todos;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueSliverWidget<ToDoResponse>(
      value: todos,
      data: (todos) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => ResponsiveCenter(
            maxContentWidth: Breakpoint.tablet,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
            child: ToDoCard(todos.data.todos[index]),
          ),
          childCount: todos.data.todos.length,
        ),
      ),
    );
  }
}
