// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromJson(jsonString);

import 'dart:convert';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? role;

  SignupResponse({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.role,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "mobile_number": mobileNumber,
        "role": role,
      };
}
