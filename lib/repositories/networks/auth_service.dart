import 'package:dio/dio.dart';
import 'package:random_picture_flutter/models/user.dart';

const _BASE_URL = "https://randompic.auth0.com";
const _CLIENT_ID = "Od7y0gWOMIudy8WLFM29wGIzmxzb5N0g";

class Auth0Service {
  final dio = Dio();

  Auth0Service() {
    dio.options = BaseOptions(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        validateStatus: (status) {
          return status < 500;
        });
  }

  Future<String> login(String email, String password) async {
    var response = await dio.post("$_BASE_URL/oauth/token", data: {
      'client_id': _CLIENT_ID,
      'username': email,
      'password': password,
      'realm': 'Username-Password-Authentication',
      'grant_type': 'http://auth0.com/oauth/grant-type/password-realm',
    });
    if (response.statusCode == 200) {
      return response.data["access_token"];
    } else {
      return Future.error(response.data['error_description']);
    }
  }

  Future<User> profile(String token) async {
    var response = await dio.get("$_BASE_URL/userinfo",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      return Future.error(response.data['error_description']);
    }
  }
}
