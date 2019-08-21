import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'repositories/caches/caches.dart';
import 'repositories/networks/networks.dart';
import 'repositories/repositories.dart';
import 'screens/screen.dart';

void main() => runApp(RandomPictureApp());

class RandomPictureApp extends StatelessWidget {
  final SessionService sessionService = SessionService();
  final SessionPreference sessionPreference = SessionPreference();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SessionRepository>(
            builder: (context) =>
                SessionRepository(sessionService, sessionPreference))
      ],
      child: MaterialApp(
        title: 'Random Picture',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          fontFamily: 'Montserrat',
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) {
            return MultiBlocProvider(providers: [
              BlocProvider<LoginBloc>(
                builder: (context) => LoginBloc(RepositoryProvider.of(context)),
              ),
            ], child: Router.findWidget(settings));
          });
        },
      ),
    );
  }
}

class Router {
  static const home = "/";
  static const login = "/login";

  static Widget findWidget(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return Home();
      case login:
        return Login();
      default:
        throw ("No route for ${settings.name}");
    }
  }
}
