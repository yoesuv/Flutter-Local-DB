import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/my_app_bloc.dart';
import 'package:flutter_local_db/src/my_app_event.dart';
import 'package:flutter_local_db/src/my_app_state.dart';
import 'package:formz/formz.dart';

class DetailArgs {
  final int id;
  DetailArgs({required this.id});
}

class Detail extends StatefulWidget {
  static const routeName = 'detail';

  const Detail({super.key, required this.args});

  final DetailArgs args;

  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

class _DetailState extends State<Detail> {
  MyAppBloc? _myAppBloc;

  @override
  void initState() {
    super.initState();
    _myAppBloc = context.read<MyAppBloc>();
    _myAppBloc?.add(MyAppGetUserEvent(id: widget.args.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<MyAppBloc, MyAppState>(
          bloc: _myAppBloc,
          buildWhen: (previous, current) =>
              previous.statusLoadUser != current.statusLoadUser,
          builder: (context, state) {
            if (state.statusLoadUser.isSuccess) {
              return _buildUser(state.user);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUser(User? user) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Id : ${widget.args.id}'),
        Text('Name : ${user?.name}'),
        Text('Username : ${user?.username}'),
        Text('Email : ${user?.email}'),
        const SizedBox(height: 8),
        const Text(
          'Address',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('Street : ${user?.address?.street}'),
        Text('Suite : ${user?.address?.suite}'),
        Text('City : ${user?.address?.city}'),
        Text('Zip Code : ${user?.address?.zipcode}'),
        Text('Geo : ${user?.address?.geo?.lat}/${user?.address?.geo?.lng}'),
        Text('Phone : ${user?.phone}'),
        Text('Website : ${user?.website}'),
        const SizedBox(height: 8),
        const Text(
          'Company',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('Name : ${user?.company?.name}'),
        Text('Catch Phrase : ${user?.company?.catchPhrase}'),
        Text('Business : ${user?.company?.bs}'),
      ],
    );
  }
}
