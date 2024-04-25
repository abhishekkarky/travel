// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

AirlineModel? airlineModelFromJson(String str) => AirlineModel.fromJson(json.decode(str));

String airlineModelToJson(AirlineModel? data) => json.encode(data!.toJson());

class AirlineModel {
  AirlineModel({
    this.id,
    this.airlineName,
    this.status,
    this.price,
    this.arrival,
    this.baggage,
    this.destination,
    this.time,
    this.imageUrl,
  });

  String? id;
  String? airlineName;
  String? status;
  String? destination;
  String? arrival;
  String? time;
  String? baggage;
  double ? price;
  String? imageUrl;

  factory AirlineModel.fromJson(Map<String, dynamic> json) => AirlineModel(
    id: json["id"],
    airlineName: json["airlineName"],
    status: json["status"],
    price: json["price"],
    destination: json["destination"],
    arrival: json["arrival"],
    time: json["time"],
    imageUrl: json["imageUrl"],
    baggage: json["baggage"],
  );

  factory AirlineModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => AirlineModel(
    id: json.id,
    airlineName: json["airlineName"],
    status: json["status"],
    imageUrl: json["imageUrl"],
    destination: json["destination"],
    price: json["price"],
    arrival: json["arrival"],
    time: json["time"],
    baggage: json["baggage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "airlineName": airlineName,
    "status": status,
    "imageUrl": imageUrl,
    "destination": destination,
    "price": price,
    "arrival": arrival,
    "baggage": baggage,
    "time": time,
  };
}
