import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class UserNameChanged extends RegisterEvent {
  final String userName;

  UserNameChanged({@required this.userName}) : super([userName]);

  @override
  String toString() => 'UserNameChanged { userName: $userName }';
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class ConfirmationPasswordChanged extends RegisterEvent {
  final String password;
  final String confirmationPassword;

  ConfirmationPasswordChanged(
      {@required this.password, @required this.confirmationPassword})
      : super([password, confirmationPassword]);

  @override
  String toString() =>
      'ConfirmationPasswordChanged { password: $password, confirmationPassword: $confirmationPassword }';
}

class FormSubmitted extends RegisterEvent {
  final String userName;
  final String email;
  final String password;

  FormSubmitted(
      {@required this.userName, @required this.email, @required this.password})
      : super([userName, email, password]);

  @override
  String toString() =>
      'FormSubmitted { userName: $userName, email: $email, password: $password }';
}
