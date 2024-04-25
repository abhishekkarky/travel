// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

BookingModel? bookingModelFromJson(String str) => BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel? data) => json.encode(data!.toJson());

class BookingModel {
  BookingModel({
    this.id,
    this.userId,
    this.productId,
    this.bookingType,
    this.bookingName,
    this.price,
    this.imageUrl,
  });

  String? id;
  String? userId;
  String? productId;
  String? bookingType;
  double? price;
  String? bookingName;
  String? imageUrl;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json["id"],
    userId: json["userId"],
    productId: json["productId"],
    bookingType: json["bookingType"],
    bookingName: json["bookingName"],
    imageUrl: json["imageUrl"],
    price: json["price"],
  );

  factory BookingModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => BookingModel(
    id: json.id,
    userId: json["userId"],
    productId: json["productId"],
    bookingType: json["bookingType"],
    price: json["price"],
    bookingName: json["bookingName"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "productId": productId,
    "bookingType": bookingType,
    "bookingName": bookingName,
    "price": price,
    "imageUrl": imageUrl,

  };
}
