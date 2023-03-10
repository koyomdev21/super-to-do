import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_to_do/src/features/authentication/presentation/email_password_sign_in_form_type.dart';
import 'package:super_to_do/src/features/location/presentation/map_screen_base.dart';
import 'package:super_to_do/src/features/splash_screen/splash.dart';
import 'package:super_to_do/src/resources_manager/local_data/local_data_repository.dart';

import '../features/authentication/presentation/email_password_sign_in_screen.dart';
import '../features/home/presentation/home_screen_base.dart';
import '../resources_manager/local_data/app_preferences.dart';
import 'not_found_screen.dart';

enum AppRoute {
  splash,
  onboarding,
  home,
  signIn,
  test,
  mapbox,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final sharedPreferences = ref.watch(appPreferencesProvider);
  final localDataRepository = ref.watch(localDataRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: const EmailPasswordSignInScreen(
            formType: EmailPasswordSignInFormType.signIn,
          ),
        ),
      ),
      GoRoute(
        path: '/mapbox',
        name: AppRoute.mapbox.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: const MapScreenBase(),
        ),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
