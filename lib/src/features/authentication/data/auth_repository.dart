import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_to_do/src/features/authentication/data/auth_data_source.dart';

import 'package:super_to_do/src/resources_manager/local_data/app_preferences.dart';

import '../../../exceptions/app_exception.dart';
import '../domain/authentication_response.dart';

class AuthRepository {
  AuthRepository(this.ref);
  final Ref ref;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final authDataSource = ref.watch(authDataSourceProvider);
    final result =
        await AsyncValue.guard(() => authDataSource.login(email, password));
    if (!result.hasError) {
      loginUser(result);
    } else {
      throw const AppException.userNotFound();
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {}

  Future<void> logout() async {
    await ref.read(appPreferencesProvider).logout();
  }

  Future<void> loginUser(AsyncValue<AuthenticationResponse> result) async {
    await ref.read(appPreferencesProvider).setLoggedIn();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final repo = AuthRepository(ref);
  return repo;
});
