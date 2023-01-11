import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../features/authentication/domain/authentication_response.dart';
import 'local_data_repository.dart';

class SembastDataRepository implements LocalDataRepository {
  SembastDataRepository(this.db);
  final Database db;
  final store = StoreRef.main();

  static Future<Database> createDatabase(String filename) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
  }

  static Future<SembastDataRepository> makeDefault() async {
    return SembastDataRepository(await createDatabase('default.db'));
  }

  static const userKey = 'users';

  @override
  Future<UserResponse?> fetchUser() async {
    final userJson = await store.record(userKey).get(db) as String?;
    if (userJson != null) {
      final data = UserResponse.fromJson(userJson);
      return data;
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteUser() {
    return store.delete(db, finder: Finder(filter: Filter.byKey(userKey)));
  }

  @override
  Future<void> setUser(UserResponse? user) {
    return store.record(userKey).put(db, user?.toJson());
  }

  @override
  Stream<UserResponse> watchUser() {
    final record = store.record(userKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot != null) {
        return UserResponse.fromJson(snapshot.value);
      } else {
        return UserResponse('', '');
      }
    });
  }
}
