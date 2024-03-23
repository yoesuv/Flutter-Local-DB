import 'package:equatable/equatable.dart';

abstract class MyAppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyAppInitUserEvent extends MyAppEvent {}
