import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../../constants/constant.dart';
import '../../../utils/dio_client.dart';
import '../domain/authentication_response.dart';

part 'auth_data_source.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) = _AuthDataSource;

  @POST("users/login")
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthDataSource(dio);
});
