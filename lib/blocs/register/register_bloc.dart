import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:random_picture_flutter/repositories/session_repository.dart';

import 'register_event.dart';
import 'register_state.dart';

export 'register_event.dart';
export 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SessionRepository _userRepository;
  final RegExp _userNameRegExp = RegExp(
    r'^.{8,}$',
  );
  final RegExp _emailRegExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final RegExp _passwordRegExp = RegExp(
    r'^.{8,}$',
  );

  RegisterBloc(this._userRepository);

  @override
  RegisterState get initialState => RegisterInitial.initial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    final currentState = this.currentState;
    if (currentState is RegisterInitial) {
      if (event is UserNameChanged) {
        yield currentState.copyWith(
          userName: event.userName,
          isUserNameValid: _isUserNameValid(event.userName),
        );
      }
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
      if (event is ConfirmationPasswordChanged) {
        yield currentState.copyWith(
          confirmationPassword: event.confirmationPassword,
          isConfirmationPasswordValid: _isConfirmationPasswordValid(
              event.password, event.confirmationPassword),
        );
      }
    }
    if (event is FormSubmitted) {
      try {
        yield RegisterLoading();
        final userName = await _userRepository.register(
            event.userName, event.email, event.password);
        yield RegisterSuccess(userName: userName);
      } catch (e) {
        yield RegisterFailed(error: e);
        yield RegisterInitial.initial();
      }
    }
  }

  bool _isUserNameValid(String userName) {
    return _userNameRegExp.hasMatch(userName);
  }

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  bool _isConfirmationPasswordValid(
      String password, String confirmationPassword) {
    return confirmationPassword == password;
  }
}
