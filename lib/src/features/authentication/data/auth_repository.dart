import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_to_do/src/features/authentication/data/auth_data_source.dart';

import 'package:super_to_do/src/resources_manager/local_data/app_preferences.dart';
import 'package:super_to_do/src/resources_manager/local_data/local_data_repository.dart';

import '../../../exceptions/app_exception.dart';
import '../domain/authentication_response.dart';

class AuthRepository {
  AuthRepository(this.ref);
  final Ref ref;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final authDataSource = ref.watch(authDataSourceProvider);
    ref.read(localDataRepositoryProvider).watchUser();
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
    await ref.read(localDataRepositoryProvider).deleteUser();
  }

  Future<void> loginUser(AsyncValue<AuthenticationResponse> result) async {
    await ref.read(appPreferencesProvider).setLoggedIn();
    await ref.read(localDataRepositoryProvider).setUser(
        UserResponse(result.value?.user?.name, result.value?.user?.phone));
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final repo = AuthRepository(ref);
  return repo;
});
