import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_to_do/src/features/home/presentation/components/bottom_sheet_todo.dart';

import '../../../../constants/app_sizes.dart';
import '../../domain/todo_response.dart';

/// Simple card widget to show a product review info (score, comment, date)
class ToDoCard extends ConsumerWidget {
  const ToDoCard(this.todo, {super.key});
  final ToDo todo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: todo.completed ?? false ? Colors.grey[100] : null,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.white,
      borderOnForeground: false,
      margin: const EdgeInsets.symmetric(vertical: 0.5),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return BottomSheetToDo(
                  todo: todo,
                );
              });
        },
        child: ListTile(
          leading: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: todo.completed,
              onChanged: (_) {}),
          title: Row(
            children: [
              Text(todo.title ?? ''),
              gapW8,
              Container(
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(Sizes.p4),
                child: Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.green[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
