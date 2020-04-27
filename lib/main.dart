import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_db/src/data/hive/address_hive.dart';
import 'package:flutter_local_db/src/data/hive/company_hive.dart';
import 'package:flutter_local_db/src/data/hive/geo_hive.dart';
import 'package:flutter_local_db/src/data/hive/user_hive.dart';
import 'package:flutter_local_db/src/my_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initHive();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
  });
}

void initHive() async {
  final Directory appDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(CompanyHiveAdapter());
  Hive.registerAdapter(UserHiveAdapter());
  Hive.registerAdapter(GeoHiveAdapter());
  Hive.registerAdapter(AddressHiveAdapter());
}