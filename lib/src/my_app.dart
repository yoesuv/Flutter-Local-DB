import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/routes/app_route.dart';
import 'package:flutter_local_db/src/my_app_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyAppBloc>(
          create: (context) => MyAppBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Local DB',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoute.routes,
      ),
    );
  }
}
