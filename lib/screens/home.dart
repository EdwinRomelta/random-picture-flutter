import 'package:flutter/material.dart';

import '../main.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Random Picture"),
        actions: null,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            GestureDetector(
                onTap: _doLogin,
                child: new UserAccountsDrawerHeader(
                  accountName: new Text("Log In"),
                  accountEmail: null,
                )
            )
          ],
        ),
      ),
    );
  }

  _doLogin() {
    Navigator.pushNamed(context, Router.login);
  }
}
