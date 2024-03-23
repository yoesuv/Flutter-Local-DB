import 'package:equatable/equatable.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:formz/formz.dart';

class MyAppState extends Equatable {
  const MyAppState({
    this.statusInsetUser = FormzSubmissionStatus.initial,
    this.users = const <User>[],
  });

  final FormzSubmissionStatus statusInsetUser;
  final List<User> users;

  MyAppState copyWith({
    FormzSubmissionStatus? statusInsetUser,
    List<User>? users,
  }) =>
      MyAppState(
        statusInsetUser: statusInsetUser ?? this.statusInsetUser,
        users: users ?? this.users,
      );

  @override
  List<Object?> get props => [
        statusInsetUser,
        users,
      ];
}
