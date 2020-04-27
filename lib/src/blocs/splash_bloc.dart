import 'package:flutter_local_db/src/models/user_model.dart';
import 'package:flutter_local_db/src/repositories/app_repository.dart';

class SplashBloc {

  final AppRepository _appRepository = AppRepository();

  Future<bool> getUsers() async {
    try {
      List<User> users = await _appRepository.getUser();
      print('Splash Bloc # users count : ${users.length}');
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

}