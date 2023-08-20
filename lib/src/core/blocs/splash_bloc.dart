import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/data/hive_constants.dart';
import 'package:flutter_local_db/src/core/events/splash_event.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/repositories/app_repository.dart';
import 'package:flutter_local_db/src/core/states/splash_state.dart';
import 'package:hive/hive.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  final AppRepository _appRepository = AppRepository();

  SplashBloc() : super(SplashStateInit()) {
    on<SplashEventInit>(_getListUser);
  }

  void _getListUser(SplashEventInit event, Emitter<SplashState> emit) async {
    Box<User> boxUsers = await Hive.openBox<User>(USERS);
    try {
      List<User> users = await _appRepository.getUser();
      await boxUsers.clear();
      for (var user in users) {
        await boxUsers.add(user);
      }
      emit(SplashStateSuccess(listUser: users));
    } catch (e) {
      emit(SplashStateFailed(e as Exception));
    }
  }

}