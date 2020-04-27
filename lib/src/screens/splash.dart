import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/blocs/splash_bloc.dart';
import 'package:flutter_local_db/src/screens/home.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SplashBloc bloc = SplashBloc();
    _getUsers(context, bloc);
    return Scaffold(
      body: Center(
        child: Text('Flutter Local DB', style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold
        )),
      ),
    );
  }

  void _getUsers(BuildContext context, SplashBloc bloc) {
    bloc.getUsers().then((bool response) {
      if (response) {
        Navigator.pushNamedAndRemoveUntil(context, Home.routeName, ModalRoute.withName('/'));
      } else {
        print('Splash # Failed get users');
      }
    });
  }

}