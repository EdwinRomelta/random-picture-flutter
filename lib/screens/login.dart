import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_picture_flutter/blocs/login/login_bloc.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, Router.home, (Route<dynamic> route) => false);
          }
          if (state is LoginFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Failed'),
              ),
            );
          }
        }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  autovalidate: true,
                  validator: (_) {
                    return state is LoginInitial && !state.isEmailValid
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
                    return state is LoginInitial && !state.isPasswordValid
                        ? "Invalid Password"
                        : null;
                  },
                ),
                Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: MaterialButton(
                        padding: const EdgeInsets.all(8),
                        child: state is LoginLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text("Login"),
                        color: Theme.of(context).accentColor,
//                  textTheme: Theme.of(context).accentTextTheme.button,
                        onPressed: () {
                          if (state is LoginInitial && state.isFormValid)
                            _onLoginPressed();
                        })),
                MaterialButton(
                  child: Text("No account yet? Create one"),
                  onPressed: () {},
                ),
              ],
            ),
          );
        })),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.dispose();
  }

  void _onEmailChange() {
    _loginBloc.dispatch(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.dispatch(PasswordChanged(password: _passwordController.text));
  }

  void _onLoginPressed() {
    _loginBloc.dispatch(FormSubmitted(
        password: _passwordController.text, email: _emailController.text));
  }
}
