import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/blocs/splash_bloc.dart';
import 'package:flutter_local_db/src/core/events/splash_event.dart';
import 'package:flutter_local_db/src/core/states/splash_state.dart';
import 'package:flutter_local_db/src/ui/screens/home.dart';
import 'package:flutter_local_db/src/ui/widgets/text_splash.dart';

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
      builder: (context, SplashState state) {
        if (state is SplashStateSuccess) {
          _openHome(context);
        }
        return Center(
          child: _textSplash(state),
        );
      },
    );
  }

  Widget _textSplash(SplashState state) {
    if (state is SplashStateSuccess) {
      return TextSplash("Init Data Done");
    } else if (state is SplashStateFailed) {
      return TextSplash("Failed Init Data");
    } else {
      return TextSplash("Flutter Local DB");
    }
  }

  void _openHome(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushNamedAndRemoveUntil(context, Home.routeName, ModalRoute.withName('/'));
    });
  }

}