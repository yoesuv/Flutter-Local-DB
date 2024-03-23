import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/my_app_event.dart';
import 'package:flutter_local_db/src/my_app_state.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  MyAppBloc() : super(const MyAppState()) {
    on<MyAppInsertUserEvent>(_onInsertUser);
  }

  void _onInsertUser(
    MyAppInsertUserEvent event,
    Emitter<MyAppState> emit,
  ) {}
}
