import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/common_methods.dart';
import 'package:food_order_app/core/common/common_string.dart';
import 'package:food_order_app/core/common/enum.dart';
import 'package:food_order_app/screens/home/model/hotel_list_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository with CommonMethods, CommonString {
  fetchhotelAPI(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'restaurants'),
        headers: {
          'Content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return hotelListResponseFromJson(response.body);
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
