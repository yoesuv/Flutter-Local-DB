import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/ui/screens/detail.dart';

class ItemUser extends StatelessWidget {
  const ItemUser(this._user, this._delete, {super.key});

  final User _user;
  final void Function(User user) _delete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: _background(),
      onDismissed: (DismissDirection direction) {
        _delete(_user);
      },
      direction: DismissDirection.endToStart,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Detail.routeName,
          arguments: DetailArgs(
            id: _user.id ?? 0,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '${_user.id}. ${_user.name}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 1, height: 1)
            ],
          ),
        ),
      ),
    );
  }

  Widget _background() {
    return Container(
      color: Colors.red,
      child: const Row(
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
