import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/my_app_bloc.dart';
import 'package:flutter_local_db/src/my_app_event.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ${widget.args.id}'),
            Text('Name : '),
            Text('Username : '),
            Text('Email : '),
            const SizedBox(height: 8),
            const Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Street : '),
            Text('Suite : '),
            Text('City : '),
            Text('Zip Code :'),
            Text('Geo : '),
            Text('Phone : '),
            Text('Website : '),
            const SizedBox(height: 8),
            const Text(
              'Company',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Name : '),
            Text('Catch Phrase : '),
            Text('Business : '),
          ],
        ),
      ),
    );
  }
}
