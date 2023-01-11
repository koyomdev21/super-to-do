import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constant.dart';

class DioClient {
  DioClient(BaseOptions? options) {
    options = BaseOptions(baseUrl: Constant.baseUrl, headers: {
      "content-type": "application/json",
      "accept": "application/json",
    });
  }
  // Dio getDio() {
  //   Dio dio = Dio();

  //   dio.options = BaseOptions(
  //     baseUrl: Constant.baseUrl,
  //     headers: {
  //       "content-type": "application/json",
  //       "accept": "application/json",
  //     },
  //   );
  //   // dio.interceptors.add(PrettyDioLogger(
  //   //   requestHeader: true,
  //   //   requestBody: true,
  //   //   responseHeader: true,
  //   //   responseBody: true,
  //   // ));
  //   return dio;
  // }
}

class AppDio with DioMixin implements Dio {
  AppDio._([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: Constant.baseUrl,
      contentType: 'application/json',
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );

    this.options = options;

    if (kDebugMode) {
      // Local Log
      interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => AppDio._();
}

final dioProvider = Provider<Dio>((ref) {
  return AppDio.getInstance();
  // return DioClient().getDio();
});
