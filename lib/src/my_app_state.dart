import 'package:equatable/equatable.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:formz/formz.dart';

class MyAppState extends Equatable {
  const MyAppState({
    this.statusInsertUser = FormzSubmissionStatus.initial,
    this.statusLoadListUser = FormzSubmissionStatus.initial,
    this.statusDeleteUser = FormzSubmissionStatus.initial,
    this.statusLoadUser = FormzSubmissionStatus.initial,
    this.users = const <User>[],
    this.user,
  });

  final FormzSubmissionStatus statusInsertUser;
  final FormzSubmissionStatus statusLoadListUser;
  final FormzSubmissionStatus statusDeleteUser;
  final FormzSubmissionStatus statusLoadUser;
  final List<User> users;
  final User? user;

  static const Object _unsetUser = Object();

  MyAppState copyWith({
    FormzSubmissionStatus? statusInsertUser,
    FormzSubmissionStatus? statusLoadListUser,
    FormzSubmissionStatus? statusDeleteUser,
    FormzSubmissionStatus? statusLoadUser,
    List<User>? users,
    Object? user = _unsetUser,
  }) => MyAppState(
    statusInsertUser: statusInsertUser ?? this.statusInsertUser,
    statusLoadListUser: statusLoadListUser ?? this.statusLoadListUser,
    statusDeleteUser: statusDeleteUser ?? this.statusDeleteUser,
    statusLoadUser: statusLoadUser ?? this.statusLoadUser,
    users: users ?? this.users,
    user: identical(user, _unsetUser) ? this.user : user as User?,
  );

  @override
  List<Object?> get props => [
    statusInsertUser,
    statusLoadListUser,
    statusDeleteUser,
    statusLoadUser,
    users,
    user,
  ];
}
