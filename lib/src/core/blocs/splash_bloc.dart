import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/events/splash_event.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/repositories/app_repository.dart';
import 'package:flutter_local_db/src/core/repositories/db_user_repository.dart';
import 'package:flutter_local_db/src/core/states/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppRepository _appRepository = AppRepository();
  final _dbUserRepository = DbUserRepository();

  SplashBloc() : super(SplashStateInit()) {
    on<SplashEventInit>(_getListUser);
  }

  void _getListUser(SplashEventInit event, Emitter<SplashState> emit) async {
    try {
      List<User> users = await _appRepository.getUser();
      await _dbUserRepository.saveData(users);
      emit(SplashStateSuccess(listUser: users));
    } catch (e) {
      if (e is Exception) {
        emit(SplashStateFailed(e));
      } else {
        emit(SplashStateFailed(Exception()));
      }
    }
  }
}
