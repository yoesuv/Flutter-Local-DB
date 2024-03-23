import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/blocs/splash_bloc.dart';
import 'package:flutter_local_db/src/core/events/splash_event.dart';
import 'package:flutter_local_db/src/core/states/splash_state.dart';
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
  SplashBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _myAppBloc = context.read<MyAppBloc>();
    _bloc = context.read<SplashBloc>();
    _bloc?.add(SplashEventInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MyAppBloc, MyAppState>(
        bloc: _myAppBloc,
        listenWhen: (previous, current) =>
            previous.statusInsetUser != current.statusInsetUser,
        listener: (context, state) {
          final sts = state.statusInsetUser;
          if (sts.isSuccess) {
            _openHome(context);
          } else if (sts.isFailure) {
            _openHome(context);
          }
        },
        child: BlocListener<SplashBloc, SplashState>(
          bloc: _bloc,
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSuccess) {
              _myAppBloc?.add(MyAppInitUserEvent(
                users: state.users,
              ));
            }
          },
          child: _splash(),
        ),
      ),
    );
  }

  Widget _splash() {
    return Center(
      child: BlocBuilder<SplashBloc, SplashState>(
        bloc: _bloc,
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          final sts = state.status;
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
