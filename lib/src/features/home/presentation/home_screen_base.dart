import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_to_do/src/features/authentication/data/auth_repository.dart';
import 'package:super_to_do/src/features/home/presentation/components/home_view_components.dart';
import 'package:super_to_do/src/routing/app_router.dart';
import 'package:super_to_do/src/utils/async_value_ui.dart';

import 'providers/home_screen_controller.dart';

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
              onPressed: () => context.goNamed(AppRoute.mapbox.name),
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                await ref.read(authRepositoryProvider).logout();
                context.goNamed(AppRoute.signIn.name);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : HomeViewComponent(state: state),
    );
  }
}
