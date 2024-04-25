import 'package:flutter/material.dart';

class DayCounter with ChangeNotifier {
  String _start = "";
  String _end = "";

  String get start => _start;
  String get end => _end;

  updateDate(String start, String end) {
    _start = start;
    _end = end;
    notifyListeners();
  }

  String _city = "";
  String get city => _city;

  String _country = "";
  String get country => _country;

  setData(String city, String country) {
    _country = country;
    _city = city;
    notifyListeners();
  }

  DateTime? _initialDate, _finalDate;
  int _count = 1;
  DayCounter() {
    DateTime currentDate = DateTime.now();
    // _initialDate = currentDate;
    _initialDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 0, 0);
    _finalDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
  }
  int get dayCount => _count;
  DateTime? get initialDate => _initialDate;
  DateTime? get finalDate => _finalDate;

  int _diffrence = 0;
  int get diffrence => _diffrence;

  countDate(String initialDate, String finalDate) async {
    _initialDate = DateTime.parse(initialDate);
    _finalDate = DateTime.parse(finalDate);
    _count = _finalDate!.difference(_initialDate!).inDays;
    _diffrence = _finalDate!.difference(_initialDate!).inHours;
    notifyListeners();
  }

  addDay() {
    _finalDate =
        DateTime(_finalDate!.year, _finalDate!.month, _finalDate!.day + 1);
    countDate(_initialDate.toString(), _finalDate.toString());
    notifyListeners();
  }
}
