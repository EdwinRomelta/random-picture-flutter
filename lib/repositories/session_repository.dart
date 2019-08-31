import 'package:random_picture_flutter/models/user.dart';

import 'caches/session_pref.dart';
import 'networks/auth_service.dart';

class SessionRepository {
  final Auth0Service userService;
  final SessionPreference userPreference;

  SessionRepository(this.userService, this.userPreference);

  Future<User> login(String email, String password) async {
    final token = await userService.login(email, password);
    final user = await userService.profile(token);
    userPreference.saveUser(user);
    return user;
  }
}
