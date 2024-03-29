import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/core/routes/app_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local DB',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      onGenerateRoute: AppRoute.routes,
    );
  }
}