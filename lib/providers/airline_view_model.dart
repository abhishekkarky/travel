import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_booking/pages/model/airline_repo.dart';
import 'package:travel_booking/pages/model/holiday_model.dart';
import 'package:travel_booking/repo/airline_repo.dart';
import 'package:travel_booking/repo/holiday_repo.dart';
import 'package:travel_booking/repo/hotel_repo.dart';

import '../pages/model/hotel_model.dart';


class AirLineViewModel with ChangeNotifier {
  AirlineRepo _airlineRepo =  AirlineRepo();
  List<AirlineModel> _airlinePackage = [];
  List<AirlineModel> get holidayPackage => _airlinePackage;

  Future<void> getAirlines() async {
    _airlinePackage = [];
    try {
      var response = await _airlineRepo.getAirlines();
      for (var element in response) {
        print(element.id);
        _airlinePackage.add(element.data());
      }
      notifyListeners();
    } catch (e) {
      print(e);
      _airlinePackage = [];
      notifyListeners();
    }
  }
}
