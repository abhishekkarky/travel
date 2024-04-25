import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/model/book_model.dart';
import '../services/firebase_service.dart';

class BookingRepo {
  final instance = FirebaseService.db.collection("bookings").withConverter(
    fromFirestore: (snapshot, _) {
      return BookingModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (BookingModel model, _) => model.toJson(),
  );

  Future<dynamic> addToCart(BookingModel data) async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        return;
      }
      FirebaseAuth.instance.currentUser!.uid;
      try {
        final response = await instance
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();
        String uid = FirebaseAuth.instance.currentUser!.uid.toString();
        final BookingModel _data = BookingModel(
            userId: uid,
            price: data.price,
            bookingType: data.bookingType,
            imageUrl: data.imageUrl,
            productId: data.productId,
            bookingName: data.bookingName);
        await instance.add(_data);
        // if (response.docs.isEmpty) {
        //
        // } else {
        //   var cart = response.docs.single.data();
        //   await instance.doc(response.docs.single.id).set(cart);
        // }
      } catch (err) {
        rethrow;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }


  Future<bool> removeBooking(String id, String userId) async {
    try {
      final response = await instance.doc(id).get();
      if (response.data()!.userId != userId) {
        return false;
      }
      await instance.doc(id).delete();
      return true;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<DocumentSnapshot<BookingModel>>> getBooking() async {
    try {
      var data = await instance.get();

      final response = await instance.get();
      var category = response.docs.where((doc) => doc['userId'] == FirebaseAuth.instance.currentUser!.uid).toList();
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  // Future<dynamic> getBooking() async {
  //   print("curre");
  //   print(FirebaseAuth.instance.currentUser);
  //   try {
  //     if (FirebaseAuth.instance.currentUser == null) {
  //       return;
  //     }
  //     FirebaseAuth.instance.currentUser!.uid;
  //     try {
  //       final response = await instance
  //           .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //           .get();
  //       return response.docs.single.data();
  //     } catch (err) {
  //       rethrow;
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  //   return null;
  // }
}
