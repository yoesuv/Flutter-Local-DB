import 'package:flutter_local_db/src/core/data/hive/address_hive.dart';
import 'package:flutter_local_db/src/core/data/hive/company_hive.dart';
import 'package:flutter_local_db/src/core/data/hive/geo_hive.dart';
import 'package:flutter_local_db/src/core/data/hive/user_hive.dart';
import 'package:flutter_local_db/src/core/data/hive_constants.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/repositories/app_repository.dart';
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
        _insertUser(boxUsers, user);
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  void _insertUser(Box<UserHive> box, User user) {
    UserHive userHive = UserHive(
      id: user.id,
      name: user.name,
      username: user.username,
      email: user.email,
      address: AddressHive(
        street: user.address.street,
        suite: user.address.suite,
        city: user.address.city,
        zipcode: user.address.zipcode,
        geo: GeoHive(
          lat: user.address.geo.lat,
          lng: user.address.geo.lng
        )
      ),
      phone: user.phone,
      website: user.website,
      company: CompanyHive(
        name: user.company.name,
        catchPhrase: user.company.catchPhrase,
        bs: user.company.bs
      )
    );
    box.add(userHive);
  }

}