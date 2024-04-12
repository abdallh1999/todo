
import 'dart:convert';

UserLoginRequest userLoginRequestFromJson(String str) => UserLoginRequest.fromJson(json.decode(str));

String userLoginRequestToJson(UserLoginRequest data) => json.encode(data.toJson());

class UserLoginRequest {
  String? username;
  String? password;
  int? expiresInMins;

  UserLoginRequest({
    this.username,
    this.password,
    this.expiresInMins,
  });

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) => UserLoginRequest(
    username: json["username"],
    password: json["password"],
    expiresInMins: json["expiresInMins"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "expiresInMins": expiresInMins,
  };
}
