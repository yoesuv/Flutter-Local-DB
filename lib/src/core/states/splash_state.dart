import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashStateInit extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashStateSuccess extends SplashState {
  final List<User> listUser;

  SplashStateSuccess({@required this.listUser});

  @override
  List<Object> get props => [listUser];
}

class SplashStateFailed extends SplashState {
  @override
  List<Object> get props => [];
}