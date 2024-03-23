import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class MyAppState extends Equatable {
  const MyAppState({
    this.statusInsetUser = FormzSubmissionStatus.initial,
  });

  final FormzSubmissionStatus statusInsetUser;

  MyAppState copyWith({
    FormzSubmissionStatus? statusInsetUser,
  }) =>
      MyAppState(
        statusInsetUser: statusInsetUser ?? this.statusInsetUser,
      );

  @override
  List<Object?> get props => [
        statusInsetUser,
      ];
}
