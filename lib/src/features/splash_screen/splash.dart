import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_to_do/src/resources_manager/local_data/app_preferences.dart';
import 'package:super_to_do/src/routing/app_router.dart';

import '../../resources_manager/assets_manager.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late Timer _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    final isLoggedIn = await ref.watch(appPreferencesProvider).isLoggedIn();

    if (isLoggedIn) {
      // navigate to home screen
      context.goNamed(AppRoute.home.name);
    } else {
      context.goNamed(AppRoute.signIn.name);
    }
  }

  // _startDelay(BuildContext context) {
  //   timer = Timer(
  //     const Duration(seconds: 1),
  //     () => myAsyncMethod(
  //       context,
  //       (() {
  //         if (!mounted) return;
  //         context.goNamed(AppRoute.home.name);
  //       }),
  //     ),
  //   );
  // }

  // Future<void> myAsyncMethod(BuildContext context, Function() onSuccess) async {
  //   await Future.delayed(const Duration(seconds: 0));
  //   if (mounted) {
  //     final sharedPreferences = ref.watch(appPreferencesProvider);
  //     await sharedPreferences.setSplashScreenViewed();
  //   }
  //   onSuccess();
  // }

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {
    //   if (mounted) _startDelay(context);
    // });
    _startDelay();
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
