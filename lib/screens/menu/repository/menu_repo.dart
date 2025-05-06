import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/common_methods.dart';
import 'package:food_order_app/core/common/common_string.dart';
import 'package:food_order_app/core/common/enum.dart';
import 'package:food_order_app/screens/menu/model/menu_model.dart';
import 'package:http/http.dart' as http;

class MenuRepo with CommonMethods, CommonString {
   fetchMenuAPI(BuildContext context, String id) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}menu?restaurant_id=$id'),
        headers: {
          'Content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return menuListResponseFromJson(response.body);
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
}
