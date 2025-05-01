import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/common_methods.dart';
import 'package:food_order_app/core/common/common_string.dart';
import 'package:food_order_app/core/common/enum.dart';
import 'package:food_order_app/screens/authendication/model/login_response_model.dart';
import 'package:food_order_app/screens/authendication/model/signup_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository with CommonMethods, CommonString {
  loginAPI(BuildContext context, Map logindetails) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + 'auth/login'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(logindetails));
      if (response.statusCode == 200) {
        return loginResponseFromJson(response.body);
      } else if (response.statusCode == 401) {
        Navigator.of(context).pop();
        flushAlert(
            context, ResponseType.failure, "Invalid User name or Password");
      } else {
        Navigator.of(context).pop();
        flushAlert(context, ResponseType.failure,
            "Something went wrong===>${response.body}");
      }
    } catch (e) {
      Navigator.of(context).pop();
      flushAlert(context, ResponseType.failure, "$e");
    }
  }

  signupAPI(BuildContext context, Map logindetails) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + 'user'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(logindetails));
      if (response.statusCode == 200) {
        return signupResponseFromJson(response.body);
      } else {
        Navigator.of(context).pop();
        flushAlert(context, ResponseType.failure, "Signup Failed");
      }
    } catch (e) {
      Navigator.of(context).pop();
      flushAlert(context, ResponseType.failure, "$e");
    }
  }
}
