// To parse this JSON data, do
//
//     final cartListResponse = cartListResponseFromJson(jsonString);

import 'dart:convert';

List<CartListResponse> cartListResponseFromJson(String str) =>
    List<CartListResponse>.from(
        json.decode(str).map((x) => CartListResponse.fromJson(x)));

String cartListResponseToJson(List<CartListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartListResponse {
  String? id;
  UserId? userId;
  List<CartItem>? cartItems;
  num? totalAmount;
  num? gstAmount;
  num? discount;
  int? v;

  CartListResponse({
    this.id,
    this.userId,
    this.cartItems,
    this.totalAmount,
    this.gstAmount,
    this.discount,
    this.v,
  });

  factory CartListResponse.fromJson(Map<String, dynamic> json) =>
      CartListResponse(
        id: json["_id"],
        userId:
            json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
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
        "user_id": userId?.toJson(),
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
  MenuId? menuId;
  int? quantity;
  String? id;

  CartItem({
    this.menuId,
    this.quantity,
    this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        menuId:
            json["menu_id"] == null ? null : MenuId.fromJson(json["menu_id"]),
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId?.toJson(),
        "quantity": quantity,
        "_id": id,
      };
}

class MenuId {
  String? id;
  String? name;
  String? restaurantId;
  String? image;
  int? price;
  int? v;

  MenuId({
    this.id,
    this.name,
    this.restaurantId,
    this.image,
    this.price,
    this.v,
  });

  factory MenuId.fromJson(Map<String, dynamic> json) => MenuId(
        id: json["_id"],
        name: json["name"],
        restaurantId: json["restaurant_id"],
        image: json["image"],
        price: json["price"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "restaurant_id": restaurantId,
        "image": image,
        "price": price,
        "__v": v,
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
