import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:food_order_app/core/common/common_methods.dart';
import 'package:food_order_app/core/common/common_string.dart';
import 'package:food_order_app/core/common/enum.dart';
import 'package:food_order_app/screens/cart/model/add_cart_response_model.dart';
import 'package:food_order_app/screens/cart/model/cart_list_model.dart';
import 'package:food_order_app/screens/cart/model/update_cart_model.dart';
import 'package:http/http.dart' as http;

class CartRepository with CommonString, CommonMethods {
  fetchcartAPI(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${baseUrl}cart?user_id=${sharedPreferences!.getString('userid')}'),
        headers: {
          'Content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return cartListResponseFromJson(response.body);
      } else {
        flushAlert(context, ResponseType.failure,
            "Something went wrong===>${response.body}");
      }
    } catch (e) {
      Navigator.of(context).pop();
      flushAlert(context, ResponseType.failure, "$e");
    }
  }

  addcartAPI(BuildContext context, Map cartdetails) async {
    try {
      final response = await http.post(Uri.parse('${baseUrl}cart'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(cartdetails));
      if (response.statusCode == 200) {
        return addCartResponseFromJson(response.body);
      } else {
        flushAlert(context, ResponseType.failure, "Item Added failed");
      }
    } catch (e) {
      flushAlert(context, ResponseType.failure, e.toString());
    }
  }

  updatecartAPI(BuildContext context, String cartid, Map cartdetails) async {
    try {
      final response = await http.patch(Uri.parse('${baseUrl}cart/$cartid'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(cartdetails));
      if (response.statusCode == 200) {
        return updateCartResponseFromJson(response.body);
      } else {
        flushAlert(context, ResponseType.failure, "Cart update failed");
      }
    } catch (e) {
      flushAlert(context, ResponseType.failure, e.toString());
    }
  }

  deletecartAPI(BuildContext context, String cartid) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}cart/$cartid'),
        headers: {
          'Content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return;
      } else {
        flushAlert(context, ResponseType.failure, "Something Went wrong");
      }
    } catch (e) {
      flushAlert(context, ResponseType.failure, e.toString());
    }
  }
}
