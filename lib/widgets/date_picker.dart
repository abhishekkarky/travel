import 'package:flutter/material.dart';

Future selectDate(context,
    {DateTime? firstDate, DateTimeRange? initialRange}) async {
  // DateTime? picked = DateTime.now();
  DateTime picked = firstDate ?? DateTime.now();
  DateTime lastdate = DateTime(2150);
  DateTimeRange? pickedRange = initialRange ??
      DateTimeRange(
          start: picked,
          end: DateTime(picked.year, picked.month, picked.day + 1));

  pickedRange = await showDateRangePicker(

    initialEntryMode: DatePickerEntryMode.calendarOnly,
    context: context,
    firstDate: DateTime.now(),
    initialDateRange: pickedRange,
    lastDate: lastdate,
  );

  return pickedRange ?? initialRange;
}

Future selectSingleDate(context,
    {DateTime? firstDate, DateTime? initialDate, DateTime? lastDate}) async {
  DateTime lastdate = lastDate ?? DateTime(2150);
  DateTime? pickedDate = initialDate ?? DateTime.now();

  pickedDate = await showDatePicker(
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    context: context,
    firstDate: firstDate ?? DateTime.now(),
    initialDate: pickedDate,
    lastDate: lastdate,

  );

  return pickedDate ?? initialDate;
}
