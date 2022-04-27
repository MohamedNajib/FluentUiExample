part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class AppDialogState extends LoginState {
  final FlowState dialog;
  AppDialogState({required this.dialog});
}
