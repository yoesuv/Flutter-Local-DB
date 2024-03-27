import 'package:equatable/equatable.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';

abstract class MyAppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyAppInitUserEvent extends MyAppEvent {}

class MyAppLoadListUserEvent extends MyAppEvent {}

class MyAppGetUserEvent extends MyAppEvent {
  MyAppGetUserEvent({required this.id});
  final int id;
  @override
  List<Object?> get props => [id];
}

class MyAppDeleteUserEvent extends MyAppEvent {
  MyAppDeleteUserEvent({required this.user});
  final User user;
  @override
  List<Object?> get props => [user];
}
