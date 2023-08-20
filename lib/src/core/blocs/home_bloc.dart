import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/data/hive_constants.dart';
import 'package:flutter_local_db/src/core/events/home_event.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/states/home_state.dart';
import 'package:hive/hive.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateInit()) {
    on<HomeEventInit>(_loadUser);
    on<HomeEventRemove>(_removeUser);
  }

  void _loadUser(HomeEventInit event, Emitter<HomeState> emit) {
    List<User> users = [];
    var box = Hive.box<User>(USERS);
    try {
      for (var user in box.values) {
        users.add(user);
      }
      emit(HomeStateSuccess(listUser: users));
    } catch (e) {
      for (var user in box.values) {
        users.add(user);
      }
      emit(HomeStateFailed(listUser: users));
    }
  }

  void _removeUser(HomeEventRemove event, Emitter<HomeState> emit) async {
    List<User> users = [];
    var box = Hive.box<User>(USERS);
    try {
      await box.deleteAt(event.index);
      for (var user in box.values) {
        users.add(user);
      }
      emit(HomeStateSuccess(listUser: users));
    } catch (e) {
      for (var user in box.values) {
        users.add(user);
      }
      emit(HomeStateFailed(listUser: users));
    }
  }
}
