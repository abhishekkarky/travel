import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_booking/pages/model/airline_repo.dart';
import 'package:travel_booking/pages/model/holiday_model.dart';
import 'package:travel_booking/repo/airline_repo.dart';
import 'package:travel_booking/repo/holiday_repo.dart';
import 'package:travel_booking/repo/hotel_repo.dart';

import '../pages/model/hotel_model.dart';

class SingleHotelViewModel with ChangeNotifier {
  HotelRepository _hotelRepository = HotelRepository();
  HotelModel? _hotel = HotelModel();
  HotelModel? get hotel => _hotel;

  Future<void> getProducts(String productId) async {
    _hotel = HotelModel();
    notifyListeners();
    try {
      var response = await _hotelRepository.getOneProduct(productId);
      _hotel = response.data();
      print("i am called");
      print(_hotel);
      notifyListeners();
    } catch (e) {
      _hotel = null;
      notifyListeners();
    }
  }



  HolidayRepository _holidayRepo = HolidayRepository();
  HolidayModel? _holidayModel = HolidayModel();
  HolidayModel? get holidayModel => _holidayModel;

  Future<void> getHolidaySingle(String productId) async {
    _holidayModel = HolidayModel();
    notifyListeners();
    try {
      var response = await _holidayRepo.getOneProduct(productId);
      _holidayModel = response.data();
      print("i am called");
      print(_holidayModel?.holidayName);
      notifyListeners();
    } catch (e) {
      _holidayModel = null;
      notifyListeners();
    }
  }




  AirlineRepo _airlineRepo = AirlineRepo();
  AirlineModel? _airlines = AirlineModel();
  AirlineModel? get airlines => _airlines;

  Future<void> getAirlines(String productId) async {
    _airlines = AirlineModel();
    notifyListeners();
    try {
      var response = await _airlineRepo.getOneAirlines(productId);
      _airlines = response.data();
      notifyListeners();
    } catch (e) {
      _airlines = null;
      notifyListeners();
    }
  }
}
