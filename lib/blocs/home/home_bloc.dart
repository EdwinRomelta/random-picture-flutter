import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:random_picture_flutter/repositories/session_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

export 'home_event.dart';
export 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SessionRepository _userRepository;

  HomeBloc(this._userRepository);

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadSession) {
      yield* _mapLoadSessionToState(event);
    } else if (event is ClearSession) {
      yield* _mapClearSessionToState(event);
    }
  }

  Stream<HomeState> _mapLoadSessionToState(
    HomeEvent event,
  ) async* {
    final user = await _userRepository.currentUser();
    if (user != null) {
      yield HomeLogged(user: user);
    } else {
      yield HomeAnonymous();
    }
  }

  Stream<HomeState> _mapClearSessionToState(
    HomeEvent event,
  ) async* {
    await _userRepository.clearUser();
    yield HomeAnonymous();
  }
}
