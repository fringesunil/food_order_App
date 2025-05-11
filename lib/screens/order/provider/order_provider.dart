import 'package:flutter/widgets.dart';
import 'package:food_order_app/core/common/common_string.dart';
import 'package:food_order_app/core/common/enum.dart';
import 'package:food_order_app/screens/cart/provider/cart_provider.dart';
import 'package:food_order_app/screens/order/model/addorder_response_model.dart';
import 'package:food_order_app/screens/order/repository/order_repository.dart';
import 'package:provider/provider.dart';

class OrderProvider extends OrderRepository with ChangeNotifier {
  AddOrderResponse? addorder;

  addOrder(BuildContext context, num totalamt, num dis, num gst, List cartitems,
      String cartid) async {
    var cartpro = Provider.of<CartProvider>(context, listen: false);
    Map orderdetails = {
      "user_id": "${sharedPreferences!.getString("userid")}",
      "total_amount": totalamt,
      "discount": dis,
      "gst_amount": gst,
      "payment_completed": true,
      "address_id": "681ff1ec8e5119506db1fd90",
      "cart_items": cartitems
    };

    addorder = await addOrderAPI(context, orderdetails);
    if (addorder!.id != null) {
      await cartpro.deleteCart(context, cartid);
      flushAlert(context, ResponseType.success, "Order added Successfully");
      notifyListeners();
    }
  }
}
