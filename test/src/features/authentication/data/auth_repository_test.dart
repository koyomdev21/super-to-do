import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_to_do/src/features/authentication/data/auth_data_source.dart';
import 'package:super_to_do/src/features/authentication/data/auth_repository.dart';
import 'package:super_to_do/src/features/authentication/domain/authentication_response.dart';
import 'package:super_to_do/src/resources_manager/local_data/app_preferences.dart';
import 'package:super_to_do/src/resources_manager/local_data/local_data_repository.dart';

import '../../../../mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const tEmail = 'test@gmail.com';
  const tPassword = 'password';
  final tUser = UserResponse('abc@gmail.com', 'password');
  final tUserNull = UserResponse('', '');
  final tUserResponse = UserResponse('qayyum', '0132470473');

  late MockLocalDataRepository localDataRepository;
  late MockAuthDataSource authDataSource;
  late MockAppPreferences appPreferences;
  setUp(() {
    authDataSource = MockAuthDataSource();
    localDataRepository = MockLocalDataRepository();
    appPreferences = MockAppPreferences();
  });

  AuthRepository makeAuthRepository() {
    final container = ProviderContainer(
      overrides: [
        authDataSourceProvider.overrideWithValue(authDataSource),
        localDataRepositoryProvider.overrideWithValue(localDataRepository),
        appPreferencesProvider.overrideWithValue(appPreferences),
      ],
    );
    addTearDown(container.dispose);
    return container.read(authRepositoryProvider);
  }

  group('auth repository', () {
    test('no user logged in and watchUser is null', () async {
      //setup
      when(localDataRepository.watchUser)
          .thenAnswer((_) => Stream.value(tUserNull));

      // run
      localDataRepository.watchUser();

      // expect
      expectLater(localDataRepository.watchUser(), emits(tUserNull));
    });

    test('sign in and return dummy AuthenticationResponse', () async {
      // setup
      when(() => authDataSource.login(tEmail, tPassword))
          .thenAnswer((_) => Future.value(AuthenticationResponse(tUser)));
      when(() => localDataRepository.setUser(tUserResponse))
          .thenAnswer((_) => Future.value());
      when(appPreferences.setLoggedIn).thenAnswer((_) => Future.value());
      when(localDataRepository.watchUser)
          .thenAnswer((_) => Stream.value(tUser));
      final authRepository = makeAuthRepository();
      // run
      await authRepository.signInWithEmailAndPassword(tEmail, tPassword);
      // verify
      verify(() => authDataSource.login(tEmail, tPassword)).called(1);
      verify(() => appPreferences.setLoggedIn()).called(1);
      expect(localDataRepository.watchUser(), emits(tUser));
    });
  });
}
