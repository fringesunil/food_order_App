import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/common_string.dart';
import 'package:food_order_app/core/common/enum.dart';
import 'package:food_order_app/core/routes/routes_string.dart';
import 'package:food_order_app/screens/cart/model/add_cart_response_model.dart';
import 'package:food_order_app/screens/cart/model/cart_list_model.dart';
import 'package:food_order_app/screens/cart/model/update_cart_model.dart';
import 'package:food_order_app/screens/cart/repository/cart_repository.dart';

class CartProvider extends CartRepository with ChangeNotifier {
  List<CartListResponse>? cartlist;
  AddCartResponse? addcart;
  List<Map<String, dynamic>> cartItemsList = [];
  UpdateCartResponse? updatecart;

  fetchcart(BuildContext context) async {
    cartlist = await fetchcartAPI(context);

    notifyListeners();
  }

  addCart(BuildContext context, String menuid, int qty) async {
    Map cartitems = {
      "user_id": "${sharedPreferences!.getString('userid')}",
      "cart_items": [
        {"menu_id": menuid, "quantity": qty},
      ]
    };
    addcart = await addcartAPI(context, cartitems);
    if (addcart!.id!.isNotEmpty) {
      flushAlert(
          context, ResponseType.success, "Item added to cart Successfully");
      notifyListeners();
    }
  }

  updateCart(BuildContext context, List cart, String cartid) async {
    Map cartitems = {"cart_items": cart};
    updatecart = await updatecartAPI(context, cartid, cartitems);
    flushAlert(context, ResponseType.success, "cart Updated Successfully");
    cartItemsList.clear();
    notifyListeners();
  }

  deleteCart(BuildContext context, String cartid) async {
    await deletecartAPI(context, cartid);
    cartItemsList.clear();
    goAndCloseAll(context, AppRoutes.home);
    notifyListeners();
  }
}
