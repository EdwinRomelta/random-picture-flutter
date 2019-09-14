import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_picture_flutter/blocs/register/register_bloc.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of(context);
    _userNameController.addListener(_onUserNameChange);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
    _confirmationPasswordController.addListener(_onConfirmationPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: BlocListener<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                if (state is RegisterSuccess) {
                  Navigator.of(context).pop(state.userName);
                }
                if (state is RegisterFailed) {
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.error),
                    ),
                  );
                }
              }, child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(labelText: 'UserName'),
                        autovalidate: true,
                        validator: (_) {
                          return state is RegisterInitial &&
                                  !state.isUserNameValid
                              ? "Invalid Username"
                              : null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        autovalidate: true,
                        validator: (_) {
                          return state is RegisterInitial && !state.isEmailValid
                              ? "Invalid Email"
                              : null;
                        },
                      ),
                      TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          autovalidate: true,
                          validator: (_) {
                            return state is RegisterInitial &&
                                    !state.isPasswordValid
                                ? "Invalid Password"
                                : null;
                          }),
                      TextFormField(
                          controller: _confirmationPasswordController,
                          decoration: InputDecoration(
                              labelText: 'Confirmation Password'),
                          obscureText: true,
                          autovalidate: true,
                          validator: (_) {
                            return state is RegisterInitial &&
                                    !state.isConfirmationPasswordValid
                                ? "Invalid Confirmation Password"
                                : null;
                          }),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: MaterialButton(
                              padding: const EdgeInsets.all(8),
                              child: state is RegisterLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : Text("Register"),
                              color: Theme.of(context).accentColor,
                              //                  textTheme: Theme.of(context).accentTextTheme.button,
                              onPressed: () {
                                if (state is RegisterInitial &&
                                    state.isFormValid) _onRegisterPressed();
                              })),
                    ],
                  ));
                },
              )))),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _registerBloc.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationPasswordController.dispose();
  }

  void _onUserNameChange() {
    _registerBloc.dispatch(UserNameChanged(userName: _userNameController.text));
  }

  void _onEmailChange() {
    _registerBloc.dispatch(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc.dispatch(PasswordChanged(password: _passwordController.text));
  }

  void _onConfirmationPasswordChange() {
    _registerBloc.dispatch(ConfirmationPasswordChanged(
        password: _passwordController.text,
        confirmationPassword: _confirmationPasswordController.text));
  }

  void _onRegisterPressed() {
    _registerBloc.dispatch(FormSubmitted(
      userName: _userNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}
