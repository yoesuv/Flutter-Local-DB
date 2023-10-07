import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/blocs/splash_bloc.dart';
import 'package:flutter_local_db/src/core/events/splash_event.dart';
import 'package:flutter_local_db/src/core/states/splash_state.dart';
import 'package:flutter_local_db/src/ui/screens/home.dart';
import 'package:flutter_local_db/src/ui/widgets/text_splash.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<Splash> {
  late SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<SplashBloc>();
    _bloc.add(SplashEventInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _splash());
  }

  Widget _splash() {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, SplashState state) {
        if (state is SplashStateSuccess) {
          _openHome(context);
        } else if (state is SplashStateFailed) {
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
      return const TextSplash("Init Data Done");
    } else if (state is SplashStateFailed) {
      return const TextSplash("Offline Mode");
    } else {
      return const TextSplash("Flutter Local DB");
    }
  }

  void _openHome(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(
        const Duration(seconds: 1),
        () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Home.routeName,
            ModalRoute.withName('/'),
          );
        },
      );
    });
  }
}
