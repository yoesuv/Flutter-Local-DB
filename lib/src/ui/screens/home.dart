import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/blocs/home_bloc.dart';
import 'package:flutter_local_db/src/core/events/home_event.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/states/home_state.dart';
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
  late HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HomeBloc>();
    _bloc.add(HomeEventInit());
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
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeStateInit) {
        return const Center(
          child: Text("Loading..."),
        );
      } else if (state is HomeStateSuccess) {
        return _buildList(state.listUser);
      } else if (state is HomeStateFailed) {
        return _buildList(state.listUser);
      } else {
        return const Center(
          child: Text("Something Wrong..."),
        );
      }
    });
  }

  Widget _buildList(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemUser(users[index], (User user) {
          _bloc.add(HomeEventRemove(index));
        });
      },
    );
  }
}
