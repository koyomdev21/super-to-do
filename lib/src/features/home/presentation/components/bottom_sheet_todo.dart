import 'package:flutter/material.dart';
import 'package:super_to_do/src/common_widgets/custom_checkbox_list_tile.dart';

import '../../../../constants/app_sizes.dart';
import '../../domain/todo_response.dart';

class BottomSheetToDo extends StatelessWidget {
  const BottomSheetToDo({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final ToDo todo;

  Widget makeDismissible(
          {required Widget child, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        makeDismissible(
          context: context,
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (context, scrollController) => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(Sizes.p16),
              child: ListView(
                controller: scrollController,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          value: true,
                          onChanged: (_) {},
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todo.title ?? '',
                              style: const TextStyle(
                                fontSize: Sizes.p16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            gapH4,
                            Text(
                              todo.image ?? '',
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            gapH4,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                Row(
                                  children: const [
                                    Icon(Icons.checklist_rounded),
                                    gapW4,
                                    Text('3/6'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(flex: 0, child: Icon(Icons.dehaze)),
                      Expanded(
                        flex: 4,
                        child: CustomCheckBoxListTile(
                          title1: 'Wash Face',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(flex: 0, child: Icon(Icons.dehaze)),
                      Expanded(
                        flex: 4,
                        child: CustomCheckBoxListTile(
                          title1: 'Gently apply to face',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(flex: 0, child: Icon(Icons.dehaze)),
                      Expanded(
                        flex: 4,
                        child: CustomCheckBoxListTile(
                          title1: 'Make sure to cover all area',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            child: Column(
              children: [
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add),
                        gapW8,
                        Text(
                          'Add Sub-task',
                          style: TextStyle(
                            fontSize: Sizes.p18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
