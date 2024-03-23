import 'package:equatable/equatable.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:formz/formz.dart';

class MyAppState extends Equatable {
  const MyAppState({
    this.statusInsertUser = FormzSubmissionStatus.initial,
    this.statusLoadListUser = FormzSubmissionStatus.initial,
    this.statusDeleteUser = FormzSubmissionStatus.initial,
    this.users = const <User>[],
  });

  final FormzSubmissionStatus statusInsertUser;
  final FormzSubmissionStatus statusLoadListUser;
  final FormzSubmissionStatus statusDeleteUser;
  final List<User> users;

  MyAppState copyWith({
    FormzSubmissionStatus? statusInsertUser,
    FormzSubmissionStatus? statusLoadListUser,
    FormzSubmissionStatus? statusDeleteUser,
    List<User>? users,
  }) =>
      MyAppState(
        statusInsertUser: statusInsertUser ?? this.statusInsertUser,
        statusLoadListUser: statusLoadListUser ?? this.statusLoadListUser,
        statusDeleteUser: statusDeleteUser ?? this.statusDeleteUser,
        users: users ?? this.users,
      );

  @override
  List<Object?> get props => [
        statusInsertUser,
        statusLoadListUser,
        statusDeleteUser,
        users,
      ];
}
