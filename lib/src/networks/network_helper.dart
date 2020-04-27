import 'package:dio/dio.dart';
import 'package:flutter_local_db/src/data/constants.dart';
import 'package:flutter_local_db/src/networks/logging_interceptor.dart';

class NetworkHelper {

  NetworkHelper() {
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: TIME_OUT,
      sendTimeout: TIME_OUT,
      receiveTimeout: TIME_OUT,
    ));
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio _dio;

  Future<dynamic> get(String url) async {
    dynamic response;
    try {
      response = await _dio.get<dynamic>(url);
    } catch (err) {
      rethrow;
    }
    return response;
  }

}