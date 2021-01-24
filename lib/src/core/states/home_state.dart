
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeStateInit extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeStateSuccess extends HomeState {
  final List<User> listUser;

  HomeStateSuccess({@required this.listUser});

  @override
  List<Object> get props => [listUser];
}

class HomeStateFailed extends HomeState {
  @override
  List<Object> get props => [];
}