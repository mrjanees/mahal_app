part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginRequested extends LoginEvent {
  final String userName;
  final String password;
  
  LoginRequested(this.userName, this.password);
}

class LogoutRequested extends LoginEvent {}
