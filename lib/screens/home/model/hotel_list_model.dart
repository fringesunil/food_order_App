// To parse this JSON data, do
//
//     final hotelListResponse = hotelListResponseFromJson(jsonString);

import 'dart:convert';

List<HotelListResponse> hotelListResponseFromJson(String str) => List<HotelListResponse>.from(json.decode(str).map((x) => HotelListResponse.fromJson(x)));

String hotelListResponseToJson(List<HotelListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelListResponse {
    String? id;
    String? name;
    String? location;
    String? image;
    int? v;

    HotelListResponse({
        this.id,
        this.name,
        this.location,
        this.image,
        this.v,
    });

    factory HotelListResponse.fromJson(Map<String, dynamic> json) => HotelListResponse(
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
