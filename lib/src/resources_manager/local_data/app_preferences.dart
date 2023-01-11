import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences();

  Future<void> setSplashScreenViewed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('splash_viewed', true);
  }

  Future<bool> isSplashScreenViewed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('splash_viewed') ?? false;
  }

  Future<void> setOnBoardingScreenViewed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_viewed', true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_viewed') ?? false;
  }

  Future<void> setLoggedIn() async {
    print('setting prefs');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', true);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('logged_in') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('logged_in');
  }
}

final appPreferencesProvider = Provider<AppPreferences>((ref) {
  return AppPreferences();
});
final appPreferencesFutureProvider = FutureProvider<AppPreferences>((ref) {
  return AppPreferences();
});
