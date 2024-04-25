// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

dateFormatter(DateTime date) {
  final DateFormat formatter = DateFormat("yyyy-MM-dd");

  return formatter.format(date);
}

dateFormatterddmm(DateTime date) {
  final DateFormat formatter = DateFormat.MMMEd();
  return formatter.format(date);
}

unixConverter(int time) {
  final date = DateTime.fromMillisecondsSinceEpoch(time);
  return dateFormatter(date);
}
