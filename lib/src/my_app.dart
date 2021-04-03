import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/core/routes/app_route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local DB',
      theme: ThemeData(
          primaryColor: Colors.teal
      ),
      onGenerateRoute: AppRoute.routes,
    );
  }
}