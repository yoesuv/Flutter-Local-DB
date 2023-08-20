import 'package:equatable/equatable.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStateInit extends HomeState {}

class HomeStateSuccess extends HomeState {
  final List<User> listUser;

  HomeStateSuccess({required this.listUser});

  @override
  List<Object> get props => [listUser];
}

class HomeStateFailed extends HomeState {
  final List<User> listUser;

  HomeStateFailed({required this.listUser});

  @override
  List<Object> get props => [listUser];
}
