import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_to_do/src/features/authentication/data/auth_repository.dart';
import 'package:super_to_do/src/features/home/presentation/todo_list.dart';
import 'package:super_to_do/src/routing/app_router.dart';
import 'package:super_to_do/src/utils/async_value_ui.dart';

import '../../../constants/app_sizes.dart';
import 'home_screen_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(homeScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(homeScreenControllerProvider);
    ref.read(homeScreenControllerProvider.notifier).fetchToDoList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Super To Do'),
        actions: [
          IconButton(
              onPressed: () => context.goNamed(AppRoute.test.name),
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () => ref.read(authRepositoryProvider).logout(),
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: Sizes.p16, vertical: Sizes.p42),
                    child: const Text(
                      'Personal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Sizes.p32),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: Sizes.p16),
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
            ),
    );
  }
}
