import 'package:flutter_local_db/src/data/hive/company_hive.dart';
import 'package:flutter_local_db/src/data/hive/user_hive.dart';
import 'package:flutter_local_db/src/data/hive_constants.dart';
import 'package:flutter_local_db/src/models/user_model.dart';
import 'package:flutter_local_db/src/repositories/app_repository.dart';
import 'package:hive/hive.dart';

class SplashBloc {

  final AppRepository _appRepository = AppRepository();

  Future<bool> getUsers() async {
    Box<UserHive> boxUsers = await Hive.openBox<UserHive>(USERS);
    boxUsers.clear();
    try {
      List<User> users = await _appRepository.getUser();
      print('Splash Bloc # users count : ${users.length}');
      users.forEach((User user){

      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

}