import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:super_to_do/src/constants/dummy/dummy_to_do_list_dio.dart';
import 'package:super_to_do/src/constants/dummy/dummy_user.dart';
import 'package:super_to_do/src/utils/dio_client.dart';

class FakeAppDio implements AppDio {
  @override
  BaseOptions get options => BaseOptions();

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) async {
    print(requestOptions.path);
    if (requestOptions.path.contains('users/login')) {
      print('route is login');
      return FakeResponse(json.decode(dummyUser) as Map<String, dynamic>?)
          as Response<T>;
    } else if (requestOptions.path.contains('users/todo-list')) {
      print('route is todo list');
      return FakeResponse(
              json.decode(dummyToDoDioList) as Map<String, dynamic>?)
          as Response<T>;
    } else {
      throw UnimplementedError();
    }
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}

class FakeResponse implements Response<Map<String, dynamic>> {
  FakeResponse(this.data);

  @override
  final Map<String, dynamic>? data;

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
