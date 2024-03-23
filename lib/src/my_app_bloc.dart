import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/repositories/db_user_repository.dart';
import 'package:flutter_local_db/src/my_app_event.dart';
import 'package:flutter_local_db/src/my_app_state.dart';
import 'package:formz/formz.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  final _dbUserRepository = DbUserRepository();

  MyAppBloc() : super(const MyAppState()) {
    on<MyAppInitUserEvent>(_onInitUser);
    on<MyAppLoadListUserEvent>(_onLoadListUser);
    on<MyAppDeleteUserEvent>(_onDeleteUser);
  }

  void _onInitUser(
    MyAppInitUserEvent event,
    Emitter<MyAppState> emit,
  ) async {
    emit(state.copyWith(
      statusInsertUser: FormzSubmissionStatus.inProgress,
    ));
    try {
      await _dbUserRepository.saveData(event.users);
      emit(state.copyWith(
        statusInsertUser: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        statusInsertUser: FormzSubmissionStatus.failure,
      ));
    }
  }

  void _onLoadListUser(
    MyAppLoadListUserEvent event,
    Emitter<MyAppState> emit,
  ) async {
    emit(state.copyWith(
      statusLoadListUser: FormzSubmissionStatus.inProgress,
    ));
    try {
      final users = await _dbUserRepository.getUsers();
      emit(state.copyWith(
        statusLoadListUser: FormzSubmissionStatus.success,
        users: users,
      ));
    } catch (e) {
      emit(state.copyWith(
        statusLoadListUser: FormzSubmissionStatus.failure,
      ));
    }
  }

  void _onDeleteUser(
    MyAppDeleteUserEvent event,
    Emitter<MyAppState> emit,
  ) async {
    emit(state.copyWith(
      statusDeleteUser: FormzSubmissionStatus.inProgress,
    ));
    try {
      await _dbUserRepository.delete(event.user);
      final users = await _dbUserRepository.getUsers();
      emit(state.copyWith(
        statusDeleteUser: FormzSubmissionStatus.success,
        users: users,
      ));
    } catch (e) {
      emit(state.copyWith(
        statusDeleteUser: FormzSubmissionStatus.failure,
      ));
    }
  }
}
