import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  final double height, fontSize;
  final double width;
  final String buttonName;
  final double borderRadius;
  double padding;
  Color buttonColor;
  Color? onPrimary;
  Color nameColor;
  bool noLeftBorderRadius = false;

  Function onClick;

  CustomButton({
    Key? key,
    this.height = 48,
    this.width = 20,
    required this.buttonName,
    this.buttonColor = lightGreen,
    this.nameColor = white,
    this.fontSize = 16.0,
    this.borderRadius = 10.0,
    this.onPrimary,
    this.padding = 14.0,
    this.noLeftBorderRadius = false,
    required this.onClick,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick();
      },
      child: ElevatedButton(
        onPressed: () {
          widget.onClick();
        },
        style: ElevatedButton.styleFrom(
            foregroundColor: widget.onPrimary, backgroundColor: widget.buttonColor, padding: EdgeInsets.all(widget.padding),
            minimumSize: Size(widget.width, widget.height),
            shape: widget.noLeftBorderRadius
                ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ))
                : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            )),
        child: Text(
          widget.buttonName,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: widget.nameColor,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontFamily: 'Muli'),
        ),
      ),
    );
  }
}
