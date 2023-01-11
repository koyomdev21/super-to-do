import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../resources_manager/assets_manager.dart';
import '../../resources_manager/local_data/app_preferences.dart';
import '../../routing/app_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late Timer timer;

  _startDelay(BuildContext context) {
    timer = Timer(
        const Duration(seconds: 1),
        () => myAsyncMethod(context, (() {
              if (!mounted) return;
              context.goNamed(AppRoute.home.name);
            })));
  }

  Future<void> myAsyncMethod(BuildContext context, Function() onSuccess) async {
    await Future.delayed(const Duration(seconds: 0));
    final sharedPreferences = ref.watch(appPreferencesProvider);
    await sharedPreferences.setSplashScreenViewed();
    onSuccess();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _startDelay(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(ImageAssets.splash),
        ),
      ),
    );
  }
}
