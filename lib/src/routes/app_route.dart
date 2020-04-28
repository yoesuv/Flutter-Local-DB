import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/data/hive/user_hive.dart';
import 'package:flutter_local_db/src/screens/detail.dart';
import 'package:flutter_local_db/src/screens/home.dart';
import 'package:flutter_local_db/src/screens/splash.dart';

class AppRoute {

  static Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return Splash();
        }
      );
    } else if (settings.name == Home.routeName) {
      return MaterialPageRoute(
          builder: (context) {
            return Home();
          }
      );
    } else if (settings.name == Detail.routeName) {
      final UserHive userHive = settings.arguments;
      return MaterialPageRoute(
          builder: (context) {
            return Detail(userHive);
          }
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          );
        }
      );
    }
  }

}