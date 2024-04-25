import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_booking/pages/model/holiday_model.dart';
import 'package:travel_booking/repo/holiday_repo.dart';
import 'package:travel_booking/repo/hotel_repo.dart';

import '../pages/model/hotel_model.dart';


class HolidayPackageViewModel with ChangeNotifier {
  HolidayRepository _holidayModel = HolidayRepository();
  List<HolidayModel> _holidayPackage = [];
  List<HolidayModel> get holidayPackage => _holidayPackage;

  Future<void> getHolidayPackage() async {
    _holidayPackage = [];
    try {
      var response = await _holidayModel.getHolidayPackage();
      for (var element in response) {
        print(element.id);
        _holidayPackage.add(element.data());
      }
      notifyListeners();
    } catch (e) {
      print(e);
      _holidayPackage = [];
      notifyListeners();
    }
  }
}
