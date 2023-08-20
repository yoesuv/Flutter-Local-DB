import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeEventInit extends HomeEvent {}

class HomeEventRemove extends HomeEvent {
  HomeEventRemove(this.index);
  final int index;
  @override
  List<Object> get props => [];
}
