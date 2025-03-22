import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mahal_app/repositories/login_repo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginRequested>(_addLoginButton);
  }

  Future<void> _addLoginButton(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final response = await loginRepository.login(
        username: event.userName, password: event.password);
    log(response.toString());
    if (response != null) {
      if (response.status!) {
        emit(LoginSuccess(response.message.toString()));
      } else {
        emit(LoginFailure(response.message.toString()));
      }
    } else {
      emit(LoginError('Something went wrong!. try again.'));
    }
  }
}
