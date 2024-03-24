import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/my_app_bloc.dart';
import 'package:flutter_local_db/src/my_app_event.dart';
import 'package:flutter_local_db/src/my_app_state.dart';
import 'package:flutter_local_db/src/ui/screens/home.dart';
import 'package:flutter_local_db/src/ui/widgets/text_splash.dart';
import 'package:formz/formz.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<Splash> {
  MyAppBloc? _myAppBloc;

  @override
  void initState() {
    super.initState();
    _myAppBloc = context.read<MyAppBloc>();
    _myAppBloc?.add(MyAppInitUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MyAppBloc, MyAppState>(
        bloc: _myAppBloc,
        listenWhen: (previous, current) =>
            previous.statusInsertUser != current.statusInsertUser,
        listener: (context, state) {
          final sts = state.statusInsertUser;
          if (sts.isSuccess) {
            _openHome(context);
          } else if (sts.isFailure) {
            _openHome(context);
          }
        },
        child: _splash(),
      ),
    );
  }

  Widget _splash() {
    return Center(
      child: BlocBuilder<MyAppBloc, MyAppState>(
        bloc: _myAppBloc,
        buildWhen: (previous, current) =>
            previous.statusInsertUser != current.statusInsertUser,
        builder: (context, state) {
          final sts = state.statusInsertUser;
          if (sts.isSuccess) {
            return const TextSplash("Init Data Done");
          } else if (sts.isFailure) {
            return const TextSplash("Offline Mode");
          }
          return const TextSplash("Flutter Local DB");
        },
      ),
    );
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
