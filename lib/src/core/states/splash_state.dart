import 'package:equatable/equatable.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashStateInit extends SplashState {}

class SplashStateSuccess extends SplashState {
  final List<User> listUser;

  SplashStateSuccess({required this.listUser});

  @override
  List<Object> get props => [listUser];
}

class SplashStateFailed extends SplashState {
  final Exception e;

  SplashStateFailed(this.e);

  @override
  List<Object> get props => [e];
}
