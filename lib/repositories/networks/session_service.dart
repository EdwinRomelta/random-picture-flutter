import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:random_picture_flutter/models/user.dart';

class SessionService {
  static const BASE_URL = "https://random-picture.appspot.com/api";

  final Dio dio = new Dio();

  Future<User> login(Map body) async {
    final response = await Dio().post('$BASE_URL/login', data: body);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.data));
    } else {
      var body = json.decode(response.data);
      return Future.error(body['error']);
    }
  }
}
