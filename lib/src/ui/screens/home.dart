import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/my_app_bloc.dart';
import 'package:flutter_local_db/src/my_app_event.dart';
import 'package:flutter_local_db/src/my_app_state.dart';
import 'package:flutter_local_db/src/ui/widgets/item_user.dart';

class Home extends StatefulWidget {
  static const String routeName = 'home';

  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  MyAppBloc? _myAppBloc;

  @override
  void initState() {
    super.initState();
    _myAppBloc = context.read<MyAppBloc>();
    _myAppBloc?.add(MyAppLoadListUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return BlocBuilder<MyAppBloc, MyAppState>(
      bloc: _myAppBloc,
      buildWhen: (previous, current) =>
          previous.statusLoadListUser != current.statusLoadListUser ||
          previous.statusDeleteUser != current.statusDeleteUser,
      builder: (context, state) {
        return _buildList(state.users);
      },
    );
  }

  Widget _buildList(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemUser(users[index], (User user) {
          _myAppBloc?.add(MyAppDeleteUserEvent(user: user));
        });
      },
    );
  }
}
