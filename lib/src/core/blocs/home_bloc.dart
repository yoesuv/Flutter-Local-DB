import 'package:bloc/bloc.dart';
import 'package:flutter_local_db/src/core/data/hive_constants.dart';
import 'package:flutter_local_db/src/core/events/home_event.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/states/home_state.dart';
import 'package:hive/hive.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  HomeBloc() : super(HomeStateInit());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if (event is HomeEventInit) {
      yield _loadUser();
    }
  }

  HomeState _loadUser() {
    try {
      List<User> users = List<User>();
      var box = Hive.box<User>(USERS);
      box.values.forEach((boxUser) {
        users.add(boxUser);
      });
      return HomeStateSuccess(listUser: users);
    } catch (e) {
      return HomeStateFailed();
    }
  }

}