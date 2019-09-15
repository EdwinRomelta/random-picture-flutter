import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:random_picture_flutter/models/user.dart';

@immutable
class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class HomeInitial extends HomeState {
  @override
  String toString() => 'HomeInitial';
}

class HomeLogged extends HomeState {
  final User user;

  HomeLogged({@required this.user}) : super([user]);

  @override
  String toString() => 'HomeLogged';
}

class HomeAnonymous extends HomeState {
  @override
  String toString() => 'HomeAnonymous';
}
