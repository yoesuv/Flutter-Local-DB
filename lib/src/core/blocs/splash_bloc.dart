import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/src/core/events/splash_event.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/repositories/app_repository.dart';
import 'package:flutter_local_db/src/core/states/splash_state.dart';
import 'package:formz/formz.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppRepository _appRepository = AppRepository();

  SplashBloc() : super(const SplashState()) {
    on<SplashEventInit>(_getListUser);
  }

  void _getListUser(
    SplashEventInit event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      List<User> users = await _appRepository.getUser();
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        users: users,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }
  }
}
