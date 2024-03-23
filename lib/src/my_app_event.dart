import 'package:equatable/equatable.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';

abstract class MyAppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyAppInitUserEvent extends MyAppEvent {
  MyAppInitUserEvent({required this.users});
  final List<User> users;
  @override
  List<Object?> get props => [users];
}
