import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/blocs/splash_bloc.dart';
import 'package:flutter_local_db/src/core/events/splash_event.dart';
import 'package:flutter_local_db/src/core/states/splash_state.dart';
import 'package:flutter_local_db/src/ui/screens/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<SplashBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => _bloc..add(SplashEventInit()),
      child: Scaffold(
        body: _splash()
      ),
    );

  }

  Widget _splash() {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        print("Splash # splash state is $state");
        return Center(
          child: Text('Flutter Local DB', style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold
          )),
        );
      },
    );
  }

}