// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

HolidayModel? holidayModelFromJson(String str) => HolidayModel.fromJson(json.decode(str));

String holidayModelToJson(HolidayModel? data) => json.encode(data!.toJson());

class HolidayModel {
  HolidayModel({
    this.id,
    this.holidayName,
    this.status,
    this.desc,
    this.price,
    this.inclusion,
    this.exclusion,
    this.imageUrl,
  });

  String? id;
  String? holidayName;
  String? status;
  String? desc;
  double ? price;
  String? imageUrl;
  String? inclusion;
  String? exclusion;

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
    id: json["id"],
    holidayName: json["holidayName"],
    status: json["status"],
    desc: json["desc"],
    price: json["price"],
    exclusion: json["exclusion"],
    inclusion: json["inclusion"],
    imageUrl: json["imageUrl"],
  );

  factory HolidayModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => HolidayModel(
    id: json.id,
    holidayName: json["holidayName"],
    status: json["status"],
    imageUrl: json["imageUrl"],
    desc: json["desc"],
    price: json["price"],
    inclusion: json["inclusion"],
    exclusion: json["exclusion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "holidayName": holidayName,
    "status": status,
    "imageUrl": imageUrl,
    "desc": desc,
    "price": price,
    "exclusion": exclusion,
    "inclusion": inclusion,
  };
}
