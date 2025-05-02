import 'package:flutter/material.dart';
import 'package:food_order_app/screens/home/model/hotel_list_model.dart';
import 'package:food_order_app/screens/home/repository/home_repository.dart';

class HomeProvider extends HomeRepository with ChangeNotifier {
  List<HotelListResponse>? hotelList;

  void fetchhotels(BuildContext context) async {
    hotelList = await fetchhotelAPI(context);
    notifyListeners();
  }
}
