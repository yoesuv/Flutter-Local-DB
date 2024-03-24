import 'package:flutter/material.dart';

class DetailArgs {
  final int id;
  DetailArgs({required this.id});
}

class Detail extends StatelessWidget {
  static const routeName = 'detail';

  const Detail({super.key, required this.args});

  final DetailArgs args;

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
            Text('Id : ${args.id}'),
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
