import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomDatePicker extends StatefulWidget {
  final String data;
  // final String date;
  final TextEditingController controller;
  final void Function()? onTap;

  const CustomDatePicker(
      {Key? key, required this.data, this.onTap, required this.controller})
      : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  void initState() {
    // widget.controller.text = dateFormatter(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap!();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        decoration: BoxDecoration(
            color: white,
            border: Border.all(color: grey_300),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data,
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: tabBlue,
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 90,
                  child: AbsorbPointer(
                    child: TextFormField(
                      maxLines: 1,
                      readOnly: true,
                      controller: widget.controller,
                      style: const TextStyle(
                          fontSize: 14,
                          color: grey_600,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Muli'),
                      decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 9)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
