import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local DB',
      theme: ThemeData(
        primaryColor: Colors.teal
      ),
      home: Scaffold(
        body: Center(
          child: Text('Flutter Local DB'),
        ),
      ),
    );
  }
}