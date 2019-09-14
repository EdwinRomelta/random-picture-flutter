import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super(props);
}

class RegisterInitial extends RegisterState {
  final String userName;
  final bool isUserNameValid;
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;
  final String confirmationPassword;
  final bool isConfirmationPasswordValid;

  bool get isFormValid => isUserNameValid && isEmailValid && isPasswordValid;

  RegisterInitial({
    @required this.userName,
    @required this.isUserNameValid,
    @required this.email,
    @required this.isEmailValid,
    @required this.password,
    @required this.isPasswordValid,
    @required this.confirmationPassword,
    @required this.isConfirmationPasswordValid,
  }) : super([
          userName,
          isUserNameValid,
          email,
          isEmailValid,
          password,
          isPasswordValid,
          confirmationPassword,
          isConfirmationPasswordValid,
        ]);

  factory RegisterInitial.initial() {
    return RegisterInitial(
      userName: '',
      isUserNameValid: true,
      email: '',
      isEmailValid: true,
      password: '',
      isPasswordValid: true,
      confirmationPassword: '',
      isConfirmationPasswordValid: true,
    );
  }

  RegisterState copyWith({
    String userName,
    bool isUserNameValid,
    String email,
    bool isEmailValid,
    String password,
    bool isPasswordValid,
    String confirmationPassword,
    bool isConfirmationPasswordValid,
  }) {
    return RegisterInitial(
      userName: userName ?? this.userName,
      isUserNameValid: isUserNameValid ?? this.isUserNameValid,
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      confirmationPassword: confirmationPassword ?? this.confirmationPassword,
      isConfirmationPasswordValid:
          isConfirmationPasswordValid ?? this.isConfirmationPasswordValid,
    );
  }

  @override
  String toString() => 'RegisterInitial';
}

class RegisterLoading extends RegisterState {
  @override
  String toString() => 'RegisterLoading';
}

class RegisterSuccess extends RegisterState {
  final String userName;

  RegisterSuccess({@required this.userName}) : super([userName]);

  @override
  String toString() => 'RegisterSuccess';
}

class RegisterFailed extends RegisterState {
  final String error;

  RegisterFailed({@required this.error}) : super([error]);

  @override
  String toString() => 'RegisterFailed { error: $error }';
}
