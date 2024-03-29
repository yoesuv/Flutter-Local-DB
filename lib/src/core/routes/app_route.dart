import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/ui/screens/detail.dart';
import 'package:flutter_local_db/src/ui/screens/home.dart';
import 'package:flutter_local_db/src/ui/screens/splash.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return const Splash();
      });
    } else if (settings.name == Home.routeName) {
      return MaterialPageRoute(builder: (context) {
        return const Home();
      });
    } else if (settings.name == Detail.routeName) {
      final args = settings.arguments as DetailArgs;
      return MaterialPageRoute(builder: (context) {
        return Detail(args: args);
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        );
      });
    }
  }
}
