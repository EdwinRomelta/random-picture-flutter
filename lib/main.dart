import 'package:flutter/material.dart';

import 'screens/screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Picture',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => Home());
        }
      },
    );
  }
}

class Router {
  static const home = "/home";
}
