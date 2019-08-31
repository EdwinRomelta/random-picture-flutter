import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String nickname;
  final String name;
  final String email;
  final String picture;
  final bool emailVerified;

  User({this.id,
    this.nickname,
    this.name,
    this.email,
    this.picture,
    this.emailVerified});

  factory User.fromJson(dynamic json) {
    return User(
        id: json['sub'],
        nickname: json['nickname'],
        name: json['name'],
        email: json['email'],
        picture: json['picture'],
        emailVerified: json['email_verified']);
  }

  Map<String, dynamic> toJson() => {
    'sub': id,
    'nickname': nickname,
        'name': name,
        'email': email,
    'picture': picture,
    'email_verified': emailVerified
      };
}
