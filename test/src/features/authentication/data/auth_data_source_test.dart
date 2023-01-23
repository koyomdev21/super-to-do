import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:super_to_do/src/features/authentication/data/auth_data_source.dart';
import 'package:super_to_do/src/features/authentication/domain/authentication_response.dart';
import 'package:super_to_do/src/utils/dio_client.dart';

import '../../../../mocks.dart';
import '../../../utils/fake_dio_client.dart';

void main() {
  late Dio dio;
  late MockDioClient dioClient;

  AuthenticationResponse response;

  group('authDataSource', () {
    const userCredentials = <String, dynamic>{
      'email': 'test@gmail.com',
      'password': 'password',
    };

    test('authDataSource', () async {
      final container = ProviderContainer(
        overrides: [
          dioProvider.overrideWithValue(FakeAppDio()),
        ],
      );
      final authDataSource = container.read(authDataSourceProvider);
      await expectLater(authDataSource.login('test@gmail.com', 'password'),
          completion(isNotNull));
    });
  });
}
