import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_booking/pages/model/airline_repo.dart';
import 'package:travel_booking/pages/model/book_model.dart';
import 'package:travel_booking/pages/model/holiday_model.dart';
import 'package:travel_booking/repo/airline_repo.dart';
import 'package:travel_booking/repo/booking_repo.dart';
import 'package:travel_booking/repo/holiday_repo.dart';
import 'package:travel_booking/repo/hotel_repo.dart';

import '../pages/model/hotel_model.dart';


class CommonViewModel with ChangeNotifier {
  List<DocumentSnapshot<BookingModel>> _holidayPackages = [];

  List<DocumentSnapshot<BookingModel>> get holidayPackages => _holidayPackages;

  // Future<void> fetchBookings() async {
  //   try {
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('bookings')
  //         .where('userId', isEqualTo: userId)
  //         .get();
  //
  //     _holidayPackages = querySnapshot.docs;
  //     notifyListeners();
  //   } catch (error) {
  //     print("Error fetching holiday packages: $error");
  //     throw error;
  //   }
  // }
}
