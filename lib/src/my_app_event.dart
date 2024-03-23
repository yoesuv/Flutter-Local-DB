import 'package:equatable/equatable.dart';

abstract class MyAppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyAppInsertUserEvent extends MyAppEvent {}
