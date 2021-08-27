import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor{

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    print('\n\n');
    print('<--- HTTP CODE : ${response.statusCode} URL : ${response.realUri.toString()}');
    print('Headers: ');
    printWrapped('Response : ${response.data}');
    print('<--- END HTTP');
  }

  void printWrapped(String text) {
    final RegExp pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((RegExpMatch match) => print(match.group(0)));
  }

}