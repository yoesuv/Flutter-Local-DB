import 'package:equatable/equatable.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:formz/formz.dart';

class SplashState extends Equatable {
  const SplashState({
    this.status = FormzSubmissionStatus.initial,
    this.users = const <User>[],
  });

  final FormzSubmissionStatus status;
  final List<User> users;

  SplashState copyWith({
    FormzSubmissionStatus? status,
    List<User>? users,
  }) =>
      SplashState(
        status: status ?? this.status,
        users: users ?? this.users,
      );

  @override
  List<Object?> get props => [
        status,
        users,
      ];
}
