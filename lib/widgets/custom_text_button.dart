// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'custom_button.dart';


// ignore: must_be_immutable
class CustomTextAndButton extends StatelessWidget {
  final String title;
  final String title_1;
  final String title_2;
  Function onRem;
  Function onTap;
  CustomTextAndButton({
    Key? key,
    required this.title,
    required this.title_1,
    required this.title_2,
    required this.onRem,
    required this.onTap,
  }) : super(key: key);

  TextStyle style = const TextStyle();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 16, top: 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                Text(
                  title,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title_1,
                ),
              ],
            ),
            Row(
              children: [
                CustomButton(
                    buttonName: "-",
                    buttonColor: lightGreen2,
                    onPrimary: lightGreen,
                    nameColor: lightGreen,
                    borderRadius: 100.0,
                    padding: 0,
                    height: 32,
                    width: 32,
                    onClick: onRem),
                const SizedBox(width: 16),
                Text(
                  title_2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 16,
                ),
                CustomButton(
                    buttonName: "+",
                    borderRadius: 100.0,
                    padding: 0,
                    height: 32,
                    width: 32,
                    onClick: onTap)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
