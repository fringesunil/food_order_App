import 'package:flutter/material.dart';
import 'package:food_order_app/screens/menu/model/menu_model.dart';
import 'package:food_order_app/screens/menu/repository/menu_repo.dart';

class MenuProvider extends MenuRepo with ChangeNotifier {
  List<MenuListResponse>? menulist;
  var quantity = 0;
  List qty = [];

  void fetchMenu(BuildContext context, String hotelid) async {
    menulist = await fetchMenuAPI(context, hotelid);
    if (menulist != null) {
      qty = List<int>.filled(menulist!.length, 0);
    }
    notifyListeners();
  }

  void incrementQuantity(int index) {
    qty[index]++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (qty[index] > 0) {
      qty[index]--;
      notifyListeners();
    }
  }

  


}
