import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_to_do/src/constants/app_sizes.dart';
import 'package:super_to_do/src/features/home/domain/todo_response.dart';
import 'package:super_to_do/src/features/home/presentation/components/todo_list.dart';

class HomeViewComponent extends StatelessWidget {
  const HomeViewComponent({
    super.key,
    required this.state,
  });

  final AsyncValue<ToDoResponse> state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: Sizes.p16, vertical: Sizes.p42),
            child: const Text(
              'Personal',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.p32),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Skincare',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.p20,
                        )),
                    gapW8,
                    Text(
                      state.value?.data.todos.length.toString() ?? '',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(
            child: Divider(
          color: Colors.black87,
          endIndent: Sizes.p16,
          indent: Sizes.p16,
        )),
        TodoList(todos: state),
      ],
    );
  }
}
