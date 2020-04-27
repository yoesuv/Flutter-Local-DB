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
        UserHive userHive = UserHive(
          id: user.id,
          name: user.name,
          username: user.username,
          email: user.email,
          phone: user.phone,
          website: user.website,
          company: CompanyHive(
            name: user.company.name,
            catchPhrase: user.company.catchPhrase,
            bs: user.company.bs
          )
        );
        boxUsers.add(userHive);
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

}