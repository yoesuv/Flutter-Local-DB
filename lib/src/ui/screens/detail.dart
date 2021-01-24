import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';

class Detail extends StatelessWidget {

  static const routeName = 'detail';

  Detail(this._user);

  final User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ${_user.id}'),
            Text('Name : ${_user.name}'),
            Text('Username : ${_user.username}'),
            Text('Email : ${_user.email}'),
            Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Street : ${_user.address.street}'),
            Text('Suite : ${_user.address.suite}'),
            Text('City : ${_user.address.city}'),
            Text('Zip Code : ${_user.address.zipcode}'),
            Text('Geo : ${_user.address.geo.lat}/${_user.address.geo.lng}'),
            Text('Phone : ${_user.phone}'),
            Text('Website : ${_user.website}'),
            Text('Company', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Name : ${_user.company.name}'),
            Text('Catch Phrase : ${_user.company.catchPhrase}'),
            Text('Business : ${_user.company.bs}'),
          ],
        ),
      ),
    );
  }

}