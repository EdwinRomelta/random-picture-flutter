import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:random_picture_flutter/models/user.dart';

@immutable
class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitial extends LoginState {
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginInitial({
    @required this.email,
    @required this.isEmailValid,
    @required this.password,
    @required this.isPasswordValid,
  }) : super([
          email,
          isEmailValid,
          password,
          isPasswordValid,
        ]);

  factory LoginInitial.initial() {
    return LoginInitial(
      email: '',
      isEmailValid: true,
      password: '',
      isPasswordValid: true,
    );
  }

  LoginState copyWith({
    String email,
    bool isEmailValid,
    String password,
    bool isPasswordValid,
  }) {
    return LoginInitial(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({@required this.user}) : super([user]);

  @override
  String toString() => 'LoginSuccess';
}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailed { error: $error }';
}
