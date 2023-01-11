import 'package:mocktail/mocktail.dart';
import 'package:super_to_do/src/features/authentication/data/auth_data_source.dart';
import 'package:super_to_do/src/features/authentication/data/auth_repository.dart';
import 'package:super_to_do/src/features/home/data/todo_data_source.dart';
import 'package:super_to_do/src/resources_manager/local_data/local_data_repository.dart';
import 'package:super_to_do/src/utils/dio_client.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLocalDataRepository extends Mock implements LocalDataRepository {}

class MockAuthDataSource extends Mock implements AuthDataSource {}

class MockToDoDataSource extends Mock implements ToDoDataSource {}

class MockDioClient extends Mock implements DioClient {}
