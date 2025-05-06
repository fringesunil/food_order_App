// To parse this JSON data, do
//
//     final menuListResponse = menuListResponseFromJson(jsonString);

import 'dart:convert';

List<MenuListResponse> menuListResponseFromJson(String str) => List<MenuListResponse>.from(json.decode(str).map((x) => MenuListResponse.fromJson(x)));

String menuListResponseToJson(List<MenuListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuListResponse {
    String? id;
    String? name;
    RestaurantId? restaurantId;
    String? image;
    int? price;
    int? v;

    MenuListResponse({
        this.id,
        this.name,
        this.restaurantId,
        this.image,
        this.price,
        this.v,
    });

    factory MenuListResponse.fromJson(Map<String, dynamic> json) => MenuListResponse(
        id: json["_id"],
        name: json["name"],
        restaurantId: json["restaurant_id"] == null ? null : RestaurantId.fromJson(json["restaurant_id"]),
        image: json["image"],
        price: json["price"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "restaurant_id": restaurantId?.toJson(),
        "image": image,
        "price": price,
        "__v": v,
    };
}

class RestaurantId {
    String? id;
    String? name;
    String? location;
    String? image;
    int? v;

    RestaurantId({
        this.id,
        this.name,
        this.location,
        this.image,
        this.v,
    });

    factory RestaurantId.fromJson(Map<String, dynamic> json) => RestaurantId(
        id: json["_id"],
        name: json["name"],
        location: json["location"],
        image: json["image"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "location": location,
        "image": image,
        "__v": v,
    };
}
