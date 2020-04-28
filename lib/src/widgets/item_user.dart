import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/data/hive/user_hive.dart';
import 'package:flutter_local_db/src/screens/detail.dart';

class ItemUser extends StatelessWidget {

  ItemUser(this._userHive);

  final UserHive _userHive;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_userHive.id.toString()),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Detail.routeName, arguments: _userHive),
        child: Container(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text('${_userHive.id}. ${_userHive.name}', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 8),
              Divider(thickness: 1, height: 1)
            ],
          ),
        ),
      ),
      background: _background(),
      onDismissed: (DismissDirection direction) {
        print('Item User # direction ${direction.toString()}');
      },
      direction: DismissDirection.endToStart,
    );
  }

  Widget _background() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(Icons.delete, color: Colors.white),
          Text('Delete', style: TextStyle(color: Colors.white)),
          SizedBox(width: 8)
        ],
      ),
    );
  }

}