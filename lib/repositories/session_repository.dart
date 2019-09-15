import 'package:random_picture_flutter/models/user.dart';

import 'caches/session_pref.dart';
import 'networks/auth_service.dart';

class SessionRepository {
  final Auth0Service userService;
  final SessionPreference userPreference;

  SessionRepository(this.userService, this.userPreference);

  Future<User> currentUser() async {
    final user = await userPreference.getUser();
    return user;
  }

  Future<void> clearUser() async {
    await userPreference.clearUser();
  }

  Future<User> login(String email, String password) async {
    final token = await userService.login(email, password);
    final user = await userService.profile(token);
    await userPreference.saveUser(user);
    return user;
  }

  Future<String> register(String username, String email,
      String password) async {
    final newUsername = await userService.register(username, email, password);
    return newUsername;
  }
}
