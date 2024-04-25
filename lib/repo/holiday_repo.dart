import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_booking/pages/model/holiday_model.dart';
import 'package:travel_booking/pages/model/hotel_model.dart';

import '../services/firebase_service.dart';

class HolidayRepository {
  CollectionReference<HolidayModel> holidayRef =
  FirebaseService.db.collection("package").withConverter<HolidayModel>(
    fromFirestore: (snapshot, _) {
      return HolidayModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );
  Future<List<QueryDocumentSnapshot<HolidayModel>>> getHolidayPackage() async {
    try {
      var data = await holidayRef.get();
      bool hasData = data.docs.isNotEmpty;
      if (!hasData) {
        creatHotels().forEach((element) async {
          await holidayRef.add(element);
        });
      }
      final response = await holidayRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<HolidayModel>> getOneProduct(String id) async {
    try {
      final response = await holidayRef.doc(id).get();
      if (!response.exists) {
        throw Exception("Holiday package doesnot exists");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
  // Future<DocumentSnapshot<HolidayModel>> getCategory(String categoryId) async {
  //   try {
  //     print(categoryId);
  //     final response = await holidayRef.doc(categoryId).get();
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  List<HolidayModel> creatHotels() {
    return [
      HolidayModel(
          holidayName: "Hamro Thailand Tour",
          status: "active",
          desc: "4 Nights/ 5 Days",
          price: 79500,
          exclusion: "Drinking",
          inclusion: "Meals, breakfast",
          imageUrl:
          "https://www.hamroholidays.com/imager.php?upfile=uploads/images/destinationTitle_1_destinationTitle_1_the%20royal%20grand%20palace.jpg&max_width=250&max_height=250"),

    ];
  }
}
