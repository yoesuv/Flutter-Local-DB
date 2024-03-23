import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/repositories/db_user_repository.dart';
import 'package:flutter_local_db/src/my_app_event.dart';
import 'package:flutter_local_db/src/my_app_state.dart';
import 'package:formz/formz.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  final _dbUserRepository = DbUserRepository();

  MyAppBloc() : super(const MyAppState()) {
    on<MyAppInitUserEvent>(_onInitUser);
    on<MyAppLoadUserEvent>(_onLoadUser);
  }

  void _onInitUser(
    MyAppInitUserEvent event,
    Emitter<MyAppState> emit,
  ) async {
    emit(state.copyWith(
      statusInsetUser: FormzSubmissionStatus.inProgress,
    ));
    try {
      await _dbUserRepository.saveData(event.users);
      emit(state.copyWith(
        statusInsetUser: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        statusInsetUser: FormzSubmissionStatus.failure,
      ));
    }
  }

  void _onLoadUser(
    MyAppLoadUserEvent event,
    Emitter<MyAppState> emit,
  ) async {
    final users = await _dbUserRepository.getUsers();
    print("MyAppBloc # users count ${users.length}");
    emit(state.copyWith(
      users: users,
    ));
  }
}
