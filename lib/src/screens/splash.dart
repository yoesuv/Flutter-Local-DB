import 'package:flutter/material.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Flutter Local DB', style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold
        )),
      ),
    );
  }

}