import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptor extends Interceptor{

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    debugPrint('\n\n');
    debugPrint('<--- HTTP CODE : ${response.statusCode} URL : ${response.realUri.toString()}');
    debugPrint('Headers: ');
    printWrapped('Response : ${response.data}');
    debugPrint('<--- END HTTP');
  }

  void printWrapped(String text) {
    final RegExp pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((RegExpMatch match) => debugPrint(match.group(0)));
  }

}