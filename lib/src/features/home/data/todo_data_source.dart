import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../../constants/constant.dart';
import '../../../utils/dio_client.dart';
import '../domain/todo_response.dart';

part 'todo_data_source.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class ToDoDataSource {
  factory ToDoDataSource(Dio dio, {String baseUrl}) = _ToDoDataSource;

  @GET("users/todo-list")
  Future<ToDoResponse> fetchTodoList();
}

final todoDataSourceProvider = Provider<ToDoDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ToDoDataSource(dio);
});
