import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/authentication/domain/authentication_response.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class LocalDataRepository {
  Future<UserResponse?> fetchUser();

  Future<void> deleteUser();

  Stream<UserResponse> watchUser();

  Future<void>? setUser(UserResponse user);
}

final localDataRepositoryProvider = Provider<LocalDataRepository>((ref) {
  // * Override this in the main method
  throw UnimplementedError();
});
