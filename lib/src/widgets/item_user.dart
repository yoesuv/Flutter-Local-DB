import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/data/hive/user_hive.dart';

class ItemUser extends StatelessWidget {

  ItemUser(this._userHive);

  final UserHive _userHive;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_userHive.id.toString()),
      child: Container(
        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${_userHive.id}. ${_userHive.name}', style: TextStyle(fontSize: 18)),
            Divider(thickness: 1)
          ],
        ),
      ),
      onDismissed: (DismissDirection direction) {

      },
      direction: DismissDirection.endToStart,
    );
  }
}