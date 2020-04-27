import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List User'),
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }

}