// To parse this JSON data, do
//
//     final updateCartResponse = updateCartResponseFromJson(jsonString);

import 'dart:convert';

UpdateCartResponse updateCartResponseFromJson(String str) =>
    UpdateCartResponse.fromJson(json.decode(str));

String updateCartResponseToJson(UpdateCartResponse data) =>
    json.encode(data.toJson());

class UpdateCartResponse {
  String? id;
  String? userId;
  List<CartItem>? cartItems;
  int? totalAmount;
  int? gstAmount;
  int? discount;
  int? v;

  UpdateCartResponse({
    this.id,
    this.userId,
    this.cartItems,
    this.totalAmount,
    this.gstAmount,
    this.discount,
    this.v,
  });

  factory UpdateCartResponse.fromJson(Map<String, dynamic> json) =>
      UpdateCartResponse(
        id: json["_id"],
        userId: json["user_id"],
        cartItems: json["cart_items"] == null
            ? []
            : List<CartItem>.from(
                json["cart_items"]!.map((x) => CartItem.fromJson(x))),
        totalAmount: json["total_amount"],
        gstAmount: json["gst_amount"],
        discount: json["discount"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "cart_items": cartItems == null
            ? []
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
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
