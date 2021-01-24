import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/ui/screens/detail.dart';

class ItemUser extends StatelessWidget {

  ItemUser(this._user);

  final User _user;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_user.id.toString()),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Detail.routeName, arguments: _user),
        child: Container(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text('${_user.id}. ${_user.name}', style: TextStyle(fontSize: 18)),
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