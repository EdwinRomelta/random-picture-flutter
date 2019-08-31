import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:random_picture_flutter/repositories/session_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

export 'login_event.dart';
export 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionRepository _userRepository;

  final RegExp _emailRegExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final RegExp _passwordRegExp = RegExp(
    r'^.{8,}$',
  );

  LoginBloc(this._userRepository);

  @override
  LoginState get initialState => LoginInitial.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    final currentState = this.currentState;
    if (currentState is LoginInitial) {
      if (event is EmailChanged) {
        yield currentState.copyWith(
          email: event.email,
          isEmailValid: _isEmailValid(event.email),
        );
      }
      if (event is PasswordChanged) {
        yield currentState.copyWith(
          password: event.password,
          isPasswordValid: _isPasswordValid(event.password),
        );
      }
    }
    if (event is FormSubmitted) {
      try {
        yield LoginLoading();
        final user = await _userRepository.login(event.email, event.password);
        yield LoginSuccess(user: user);
      } catch (e) {
        yield LoginFailed(error: e);
        yield LoginInitial.initial();
      }
    }
  }

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
