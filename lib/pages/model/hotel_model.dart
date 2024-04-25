// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

HotelModel? hotelModelFromJson(String str) => HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel? data) => json.encode(data!.toJson());

class HotelModel {
  HotelModel({
    this.id,
    this.hotelName,
    this.location,
    this.desc,
    this.price,
    this.rooms,
    this.ratings,
    this.imageUrl,
  });

  String? id;
  String? hotelName;
  String? location;
  String? desc;
  double ? price;
  int? rooms;
  int? ratings;
  String? imageUrl;

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
    id: json["id"],
    hotelName: json["hotelName"],
    location: json["location"],
    desc: json["desc"],
    ratings: json["ratings"],
    price: json["price"],
    rooms: json["rooms"],
    imageUrl: json["imageUrl"],
  );

  factory HotelModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => HotelModel(
    id: json.id,
    hotelName: json["hotelName"],
    location: json["location"],
    imageUrl: json["imageUrl"],
    desc: json["desc"],
    ratings: json["ratings"],
    price: json["price"],
    rooms: json["rooms"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hotelName": hotelName,
    "location": location,
    "ratings": ratings,
    "imageUrl": imageUrl,
    "desc": desc,
    "price": price,
    "rooms": rooms,
  };
}
