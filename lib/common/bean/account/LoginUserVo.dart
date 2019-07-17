import 'package:flutter_app/core/base/CoreVo.dart';

class LoginUserVo extends CoreVo {
  bool admin;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String token;
  int type;
  String username;
  int test;

  LoginUserVo(
      {this.admin,
      this.email,
      this.icon,
      this.id,
      this.nickname,
      this.password,
      this.token,
      this.type,
      this.username});

  LoginUserVo.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['email'] = this.email;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['token'] = this.token;
    data['type'] = this.type;
    data['username'] = this.username;
    return data;
  }
}
