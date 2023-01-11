import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_to_do/src/features/authentication/data/auth_repository.dart';
import 'package:super_to_do/src/features/authentication/domain/authentication_response.dart';
import 'package:super_to_do/src/features/authentication/presentation/email_password_sign_in_controller.dart';
import 'package:super_to_do/src/features/authentication/presentation/email_password_sign_in_form_type.dart';

import '../../../../mocks.dart';

void main() {
  ProviderContainer makeProviderContainer(MockAuthRepository authRepository) {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  const tFormType = EmailPasswordSignInFormType.signIn;
  var tUserResponse = AuthenticationResponse(UserResponse(tEmail, tPassword));
  group('EmailSignInController', () {
    test('sign in success', () async {
      //setup
      final authRepository = MockAuthRepository();
      when(() => authRepository.signInWithEmailAndPassword(tEmail, tPassword))
          .thenAnswer((_) => Future.value());
      final container = makeProviderContainer(authRepository);
      final controller =
          container.read(emailPasswordSignInControllerProvider.notifier);
      // expect later
      expectLater(
        controller.stream,
        emitsInOrder([
          const AsyncLoading<void>(),
          const AsyncData<void>(null),
        ]),
      );
      // run
      final result = await controller.submit(
        email: tEmail,
        password: tPassword,
        formType: tFormType,
      );
      // verify
      expect(result, true);
    });

    test('sign in failure', () async {
      //setup
      final authRepository = MockAuthRepository();
      final exception = Exception('connection failed');
      when(() => authRepository.signInWithEmailAndPassword(tEmail, tPassword))
          .thenThrow(exception);
      final container = makeProviderContainer(authRepository);
      final controller =
          container.read(emailPasswordSignInControllerProvider.notifier);
      // expect later
      expectLater(
        controller.stream,
        emitsInOrder([
          const AsyncLoading<void>(),
          predicate<AsyncValue<void>>((state) {
            expect(state.hasError, true);
            return true;
          }),
        ]),
      );
      // run
      final result = await controller.submit(
        email: tEmail,
        password: tPassword,
        formType: tFormType,
      );
      // verify
      expect(result, false);
    });
  });
}
