// To parse this JSON data, do
//
//     final addOrderResponse = addOrderResponseFromJson(jsonString);

import 'dart:convert';

AddOrderResponse addOrderResponseFromJson(String str) =>
    AddOrderResponse.fromJson(json.decode(str));

String addOrderResponseToJson(AddOrderResponse data) =>
    json.encode(data.toJson());

class AddOrderResponse {
  UserId? userId;
  num? totalAmount;
  num? discount;
  num? gstAmount;
  bool? paymentCompleted;
  String? addressId;
  List<CartItem>? cartItems;
  String? id;
  int? v;

  AddOrderResponse({
    this.userId,
    this.totalAmount,
    this.discount,
    this.gstAmount,
    this.paymentCompleted,
    this.addressId,
    this.cartItems,
    this.id,
    this.v,
  });

  factory AddOrderResponse.fromJson(Map<String, dynamic> json) =>
      AddOrderResponse(
        userId:
            json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
        totalAmount: json["total_amount"],
        discount: json["discount"],
        gstAmount: json["gst_amount"]?.toDouble(),
        paymentCompleted: json["payment_completed"],
        addressId: json["address_id"],
        cartItems: json["cart_items"] == null
            ? []
            : List<CartItem>.from(
                json["cart_items"]!.map((x) => CartItem.fromJson(x))),
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId?.toJson(),
        "total_amount": totalAmount,
        "discount": discount,
        "gst_amount": gstAmount,
        "payment_completed": paymentCompleted,
        "address_id": addressId,
        "cart_items": cartItems == null
            ? []
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        "_id": id,
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

class UserId {
  String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? mobileNumber;
  String? role;
  int? v;

  UserId({
    this.id,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.mobileNumber,
    this.role,
    this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
        mobileNumber: json["mobile_number"],
        role: json["role"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
        "mobile_number": mobileNumber,
        "role": role,
        "__v": v,
      };
}
