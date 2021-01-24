import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/blocs/home_bloc.dart';
import 'package:flutter_local_db/src/core/routes/app_route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Local DB',
        theme: ThemeData(
            primaryColor: Colors.teal
        ),
        onGenerateRoute: AppRoute.routes,
      )
    );

  }
}