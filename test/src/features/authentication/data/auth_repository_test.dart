import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_to_do/src/features/authentication/data/auth_repository.dart';
import 'package:super_to_do/src/features/authentication/domain/authentication_response.dart';
import 'package:super_to_do/src/resources_manager/local_data/local_data_repository.dart';

import '../../../../mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const tEmail = 'test@gmail.com';
  const tPassword = 'password';
  final tUser = UserResponse('abc@gmail.com', 'password');
  final tUserResponse = UserResponse('qayyum', '0132470473');

  late MockLocalDataRepository localDataRepository;
  late MockAuthDataSource authDataSource;
  setUp(() {
    localDataRepository = MockLocalDataRepository();
    authDataSource = MockAuthDataSource();
  });

  AuthRepository makeAuthRepository() {
    final container = ProviderContainer(overrides: [
      localDataRepositoryProvider.overrideWithValue(localDataRepository),
    ]);
    addTearDown(container.dispose);
    return container.read(authRepositoryProvider);
  }

  group('auth repository', () {
    test('no user logged in and watchUser is null', () {
      //setup
      makeAuthRepository();
      when(localDataRepository.watchUser)
          .thenAnswer((_) => Stream.value(UserResponse('', '')));
      expect(localDataRepository.watchUser(), emits(UserResponse('', '')));
    });

    // test('sign in and return dummy AuthenticationResponse', () async {
    //   // setup
    //   when(() => authDataSource.login(tEmail, tPassword))
    //       .thenAnswer((_) => Future.value(dummyUser));
    //   when(() => localDataRepository.setUser(tUserResponse))
    //       .thenAnswer((_) => Future.value());
    //   when(localDataRepository.watchUser)
    //       .thenAnswer((_) => Stream.value(tUser));
    //   final authRepository = makeAuthRepository();
    //   // run
    //   await authRepository.signInWithEmailAndPassword(tEmail, tPassword);
    //   // await expectLater(
    //   //     authDataSource.login(tEmail, tPassword), completion(dummyUser));
    //   // verify
    //   expect(localDataRepository.watchUser(), emits(tUser));
    // });
  });
}
