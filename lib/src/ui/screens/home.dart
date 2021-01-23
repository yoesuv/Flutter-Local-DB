import 'package:flutter/material.dart';
import 'package:flutter_local_db/src/core/data/hive_constants.dart';
import 'package:flutter_local_db/src/core/data/hive/user_hive.dart';
import 'package:flutter_local_db/src/ui/widgets/item_user.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatelessWidget {

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List User'),
      ),
      body: _buildList()
    );
  }

  Widget _buildList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<UserHive>(USERS).listenable(),
      builder: (BuildContext context, Box<UserHive> box, Widget _) {
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemUser(box.getAt(index));
          },
        );
      },
    );
  }

}