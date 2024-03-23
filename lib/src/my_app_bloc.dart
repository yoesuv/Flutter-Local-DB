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
    on<MyAppDeleteUserEvent>(_onDeleteUser);
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
    emit(state.copyWith(
      users: users,
    ));
  }

  void _onDeleteUser(
    MyAppDeleteUserEvent event,
    Emitter<MyAppState> emit,
  ) async {
    print("MyAppBloc # DELETE USER ${event.user.toJson()}");
  }
}
