import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_to_do/src/resources_manager/local_data/local_data_repository.dart';

import '../data/auth_repository.dart';
import 'email_password_sign_in_form_type.dart';

class EmailPasswordSignInController extends StateNotifier<AsyncValue<void>> {
  EmailPasswordSignInController(this.ref) : super(const AsyncData<void>(null));
  final Ref ref;

  Future<bool> submit(
      {required String email,
      required String password,
      required EmailPasswordSignInFormType formType}) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => _authenticate(email, password, formType));
    return state.hasError == false;
  }

  Future<void> _authenticate(
      String email, String password, EmailPasswordSignInFormType formType) {
    final authRepository = ref.read(authRepositoryProvider);
    // switch (formType) {
    //   case EmailPasswordSignInFormType.signIn:
    return authRepository.signInWithEmailAndPassword(email, password);
    // case EmailPasswordSignInFormType.register:
    // return authRepository.createUserWithEmailAndPassword(email, password);
    // }
  }

  Future<void> logout() async {
    await ref.read(localDataRepositoryProvider).deleteUser();
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authRepository.logout());
  }
}

final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose<
    EmailPasswordSignInController, AsyncValue<void>>((ref) {
  return EmailPasswordSignInController(ref);
});
