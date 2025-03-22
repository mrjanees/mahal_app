part of 'login_bloc.dart';

@immutable
sealed class LoginState {}


class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  LoginSuccess(this.message);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class LoginInProgress extends LoginState {}


class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
} 