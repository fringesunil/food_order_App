// To parse this JSON data, do
//
//     final addCartResponse = addCartResponseFromJson(jsonString);

import 'dart:convert';

AddCartResponse addCartResponseFromJson(String str) =>
    AddCartResponse.fromJson(json.decode(str));

String addCartResponseToJson(AddCartResponse data) =>
    json.encode(data.toJson());

class AddCartResponse {
  String? userId;
  List<CartItem>? cartItems;
  String? id;
  int? totalAmount;
  double? gstAmount;
  int? discount;
  int? v;

  AddCartResponse({
    this.userId,
    this.cartItems,
    this.id,
    this.totalAmount,
    this.gstAmount,
    this.discount,
    this.v,
  });

  factory AddCartResponse.fromJson(Map<String, dynamic> json) =>
      AddCartResponse(
        userId: json["user_id"],
        cartItems: json["cart_items"] == null
            ? []
            : List<CartItem>.from(
                json["cart_items"]!.map((x) => CartItem.fromJson(x))),
        id: json["_id"],
        totalAmount: json["total_amount"],
        gstAmount: json["gst_amount"]?.toDouble(),
        discount: json["discount"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "cart_items": cartItems == null
            ? []
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        "_id": id,
        "total_amount": totalAmount,
        "gst_amount": gstAmount,
        "discount": discount,
        "__v": v,
      };
}

class CartItem {
  String? menuId;
  int? quantity;
  String? id;

  CartItem({
    this.menuId,
    this.quantity,
    this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        menuId: json["menu_id"],
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "quantity": quantity,
        "_id": id,
      };
}
