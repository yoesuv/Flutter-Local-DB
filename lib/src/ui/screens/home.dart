import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/blocs/home_bloc.dart';
import 'package:flutter_local_db/src/core/events/home_event.dart';
import 'package:flutter_local_db/src/core/states/home_state.dart';
import 'package:flutter_local_db/src/ui/widgets/item_user.dart';

class Home extends StatefulWidget {

  static const String routeName = 'home';

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List User'),
      ),
      body: BlocProvider(
        create: (context) => _bloc..add(HomeEventInit()),
        child: _buildList(),
      )
    );
  }

  Widget _buildList() {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          print("Home # state listener is $state");
        },
        builder: (context, state) {
          print("Home # state is $state");
          if (state is HomeStateInit) {
            return Center(
              child: Text("Loading..."),
            );
          } else if (state is HomeStateSuccess) {
            return ListView.builder(
              itemCount: state.listUser.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemUser(state.listUser[index]);
              },
            );
          } else if (state is HomeStateFailed) {
            return Center(
              child: Text("Failed.."),
            );
          } else {
            return Center(
              child: Text("Something Wrong..."),
            );
          }
        }
    );
  }

}