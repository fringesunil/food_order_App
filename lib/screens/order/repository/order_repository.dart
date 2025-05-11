import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:food_order_app/core/common/common_methods.dart';
import 'package:food_order_app/core/common/common_string.dart';
import 'package:food_order_app/core/common/enum.dart';
import 'package:food_order_app/screens/order/model/addorder_response_model.dart';
import 'package:http/http.dart' as http;

class OrderRepository with CommonString, CommonMethods {
  addOrderAPI(BuildContext context, Map orderdetails) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + 'order'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(orderdetails));
      if (response.statusCode == 200) {
        return addOrderResponseFromJson(response.body);
      } else {
        Navigator.of(context).pop();
        flushAlert(context, ResponseType.failure,
            "Something went wrong");
      }
    } catch (e) {
      print(e);
    }
  }
}
