import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_booking/repo/hotel_repo.dart';

import '../pages/model/hotel_model.dart';


class HotelViewModel with ChangeNotifier {
  HotelRepository _hotelModel = HotelRepository();
  List<HotelModel> _hotels = [];
  List<HotelModel> get hotels => _hotels;

  Future<void> getHotels() async {
    _hotels = [];
    try {
      var response = await _hotelModel.getHotels();
      for (var element in response) {
        _hotels.add(element.data());
      }
      notifyListeners();
    } catch (e) {
      _hotels = [];
      notifyListeners();
    }
  }
}
