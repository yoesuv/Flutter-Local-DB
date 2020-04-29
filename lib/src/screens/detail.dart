import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/data/hive/user_hive.dart';

class Detail extends StatelessWidget {

  static const routeName = 'detail';

  Detail(this._userHive);

  final UserHive _userHive;

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
            Text('Id : ${_userHive.id}'),
            Text('Name : ${_userHive.name}'),
            Text('Username : ${_userHive.username}'),
            Text('Email : ${_userHive.email}'),
            Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Street : ${_userHive.address.street}'),
            Text('Suite : ${_userHive.address.suite}'),
            Text('City : ${_userHive.address.city}'),
            Text('Zip Code : ${_userHive.address.zipcode}'),
            Text('Geo : ${_userHive.address.geo.lat}/${_userHive.address.geo.lng}'),
            Text('Phone : ${_userHive.phone}'),
            Text('Website : ${_userHive.website}'),
            Text('Company', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Name : ${_userHive.company.name}'),
            Text('Catch Phrase : ${_userHive.company.catchPhrase}'),
            Text('Business : ${_userHive.company.bs}'),
          ],
        ),
      ),
    );
  }

}