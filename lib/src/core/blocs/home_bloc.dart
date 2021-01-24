import 'package:bloc/bloc.dart';
import 'package:flutter_local_db/src/core/events/home_event.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/states/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  HomeBloc() : super(HomeStateInit());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    print("HomeBloc # event is : $event");
    if (event is HomeEventInit) {
      yield _loadUser();
    }
  }

  HomeState _loadUser() {
    print("Home Bloc # try load user");
    try {
      List<User> users = List<User>();
      users.add(User(id: 1, name: "Yusuf", username: "yoesuv"));
      return HomeStateSuccess(listUser: users);
    } catch (e) {
      print("Home Bloc # failed load hive users $e");
      return HomeStateFailed();
    }
  }

}