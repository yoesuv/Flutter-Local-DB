import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/ui/screens/detail.dart';
import 'package:flutter_local_db/src/ui/screens/home.dart';
import 'package:flutter_local_db/src/ui/screens/splash.dart';

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
      final User user = settings.arguments;
      return MaterialPageRoute(
          builder: (context) {
            return Detail(user);
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