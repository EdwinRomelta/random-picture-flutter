import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_picture_flutter/blocs/home/home_bloc.dart';
import 'package:random_picture_flutter/models/user.dart';

import '../main.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of(context);
    _homeBloc.dispatch(LoadSession());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Random Picture"),
        actions: null,
      ),
      drawer: new Drawer(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final user = state is HomeLogged ? state.user : null;
          List<Widget> menuList = [];
          menuList.add(_userWidget(user));
          if (user != null) {
            menuList.addAll(_createLoggedMenu());
          }
          return new ListView(
            children: menuList,
          );
        },
      )),
    );
  }

  @override
  void dispose() {
    _homeBloc.dispose();
  }

  Widget _userWidget(User user) {
    Widget header;
    if (user != null) {
      header = new UserAccountsDrawerHeader(
          accountName: new Text(user.name),
          accountEmail: new Text(user.email),
          currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                user.picture,
              )));
    } else {
      header = new UserAccountsDrawerHeader(
          accountName: new Text("Log In"), accountEmail: null);
    }
    return GestureDetector(
        onTap: user == null ? _toLogin : null, child: header);
  }

  List<Widget> _createLoggedMenu() {
    return [
      _createDrawerItem(
          icon: Icons.exit_to_app, text: "Log Out", onTap: _doLogOut),
    ];
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  _doLogOut() {
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Log Out'),
            content: Text('Are you sure you want to logout?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
              FlatButton(
                onPressed: () {
                  _onLogOut();
                  Navigator.of(context).pop();
                },
                child: Text('Yes'),
              )
            ],
          );
        });
  }

  void _onLogOut() {
    _homeBloc.dispatch(ClearSession());
  }

  _toLogin() {
    Navigator.pushNamed(context, Router.login);
  }
}
