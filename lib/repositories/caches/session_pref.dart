import 'dart:convert';

import 'package:random_picture_flutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionPreference {
  static const _KEY = "pref-session";

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_KEY);
    if (userJson != null) return User.fromJson(json.decode(userJson));
    return null;
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_KEY, json.encode(user.toJson()));
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
