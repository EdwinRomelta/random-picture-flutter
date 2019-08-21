import 'package:random_picture_flutter/models/user.dart';

import 'caches/session_pref.dart';
import 'networks/session_service.dart';

class SessionRepository {
  final SessionService userService;
  final SessionPreference userPreference;

  SessionRepository(this.userService, this.userPreference);

  Future<User> login(Map body) async {
    final user = await userService.login(body);
    userPreference.saveUser(user);
    return user;
  }
}
