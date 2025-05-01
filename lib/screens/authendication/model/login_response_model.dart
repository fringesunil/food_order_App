// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? status;
  Data? data;

  LoginResponse({
    this.status,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? name;
  String? email;
  String? role;

  Data({
    this.id,
    this.name,
    this.email,
    this.role,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "role": role,
      };
}
