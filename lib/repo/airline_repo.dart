import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_booking/pages/model/holiday_model.dart';
import 'package:travel_booking/pages/model/hotel_model.dart';

import '../pages/model/airline_repo.dart';
import '../services/firebase_service.dart';

class AirlineRepo {
  CollectionReference<AirlineModel> airlineRef =
  FirebaseService.db.collection("airlines").withConverter<AirlineModel>(
    fromFirestore: (snapshot, _) {
      return AirlineModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );

  Future<List<QueryDocumentSnapshot<AirlineModel>>> getAirlines() async {
    try {
      var data = await airlineRef.get();
      bool hasData = data.docs.isNotEmpty;
      if (!hasData) {
        creatHotels().forEach((element) async {
          await airlineRef.add(element);
        });
      }
      final response = await airlineRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<AirlineModel>> getOneAirlines(String id) async {
    try {
      final response = await airlineRef.doc(id).get();
      if (!response.exists) {
        throw Exception("Airlines doesnot exists");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  List<AirlineModel> creatHotels() {
    return [
      AirlineModel(
          time: "7:30 AM",
          status: "active",
          destination: "Kathmandu",
          price: 15000,
          airlineName: "Buddha Airlines",
          arrival: "Butwal",
          baggage: "25 K.g",
          imageUrl:
          "https://play-lh.googleusercontent.com/zOYGL7yIvz96so40Xt2WXuXYDI69mlpE8tDBQezu74_l3Lb8derfMT-Iy3dHN1EWvcs"),

    ];
  }
}
