import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FlightSettingProvider extends ChangeNotifier {
  int _adultCount = 1;
  // int _seniorCount = 0;
  int _childrenCount = 0;
  int _infantOnLapCount = 0;
  int _infantOnSeatCount = 0;
  int _totalCount = 1;

  //cabin type
  bool _economyCabin = true;
  bool _premiumEconomyCabin = false;
  bool _businessCabin = false;
  DateTime? _departingDate, _returningDate;
  int get adultCount => _adultCount;
  // int get seniorCount => _seniorCount;
  int get childrenCount => _childrenCount;
  int get infantOnLapCount => _infantOnLapCount;
  int get infantOnSeatCount => _infantOnSeatCount;
  int get totalCount => _totalCount;
  DateTime get departingDate => _departingDate!;
  DateTime get returningDate => _returningDate!;

  String _slug = "E";
  String get slug => _slug;

  //flight Type
  bool _isTwoWay = false;
  String _flightType = "One way";

  //get Cabin
  bool get economyCabin => _economyCabin;
  bool get premiumEconomyCabin => _premiumEconomyCabin;
  bool get businessCabin => _businessCabin;

  // Flight type
  bool get isTwoWay => _isTwoWay;
  String get flightType => _flightType;

  FlightSettingProvider() {
    DateTime currentDate = DateTime.now();

    _departingDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 0, 0);
    _returningDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
  }
  setDepartingDate(DateTime date) {
    _departingDate = date;
    _returningDate = DateTime(
        _departingDate!.year, _departingDate!.month, _departingDate!.day + 1);
    notifyListeners();
  }

  setReturningDate(DateTime date) {
    _returningDate = date;
    notifyListeners();
  }

  addAdult() {
    var total = _childrenCount + _adultCount;
    if (total >= 9) {
    } else {
      _adultCount++;
      _totalCount++;
      notifyListeners();
    }
  }
  //
  // addSenior() {
  //   _seniorCount++;
  //   _totalCount++;
  //
  //   notifyListeners();
  // }

  addChildren() {
    var total = _childrenCount + _adultCount;
    if (total == 9) {
    } else {
      _childrenCount++;
      _totalCount++;
      notifyListeners();
    }
  }

  addInfantOnLap() {
    if (_infantOnLapCount >= _adultCount) {
    } else {
      _infantOnLapCount++;
      _totalCount++;
      notifyListeners();
    }
  }

  addInfantOnSeat() {
    _infantOnSeatCount++;
    _totalCount++;
    notifyListeners();
  }

////remove

  removeAdult() {
    if (_adultCount == _infantOnLapCount) {
      _adultCount--;
      _infantOnLapCount = _infantOnLapCount - 1;
      _totalCount--;
      notifyListeners();
    } else {
      _adultCount--;
      _totalCount--;
      notifyListeners();
    }
  }

  // removeSenior() {
  //   if (_seniorCount > 0) {
  //     _seniorCount--;
  //     _totalCount--;
  //     notifyListeners();
  //   }
  // }

  removeChildren() {
    if (_childrenCount > 0) {
      _childrenCount--;
      _totalCount--;
      notifyListeners();
    }
  }

  removeInfantOnLap() {
    if (_infantOnLapCount > 0) {
      _infantOnLapCount--;
      _totalCount--;
      notifyListeners();
    }
  }

  removeInfantOnSeat() {
    if (_infantOnSeatCount > 0) {
      _infantOnSeatCount--;
      _totalCount--;
      notifyListeners();
    }
  }

  ///cabin
  setEconomyCabin() {
    _economyCabin = true;
    _premiumEconomyCabin = false;
    _businessCabin = false;
    notifyListeners();
  }

  setPremiumEconomyCabin() {
    _economyCabin = false;
    _premiumEconomyCabin = true;
    _businessCabin = false;
    notifyListeners();
  }

  setBusinessCabin() {
    _economyCabin = false;
    _premiumEconomyCabin = false;
    _businessCabin = true;
    notifyListeners();
  }

  //Flight Type

  changeFlightType(String value) {
    _flightType = value;
    value == "Round trip" ? _isTwoWay = true : _isTwoWay = false;
    notifyListeners();
  }

  setCabinSlug() {
    if (_economyCabin == true) {
      _slug = "E";
      notifyListeners();
    } else if (_businessCabin == true) {
      _slug = "B";
      notifyListeners();
    } else if (_premiumEconomyCabin == true) {
      _slug = "P";
      notifyListeners();
    }
  }



}
