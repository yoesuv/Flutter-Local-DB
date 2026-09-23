import 'package:dio/dio.dart';
import 'package:flutter_local_db/src/core/data/constants.dart';
import 'package:flutter_local_db/src/core/networks/logging_interceptor.dart';

class NetworkHelper {
  NetworkHelper() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: TIME_OUT,
        sendTimeout: TIME_OUT,
        receiveTimeout: TIME_OUT,
      ),
    );
    _dio.interceptors.add(LoggingInterceptor());
  }

  late Dio _dio;

  Future<Response<dynamic>> get(String url) {
    return _dio.get<dynamic>(url);
  }
}
