import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color backColor;
  final Color textColor;
  final double fontSize;
  final Function() function;

  const CustomButton(
      {super.key,
      required this.text,
      this.width = 300,
      this.height = 50,
      this.backColor = white,
      this.textColor = black,
      this.fontSize = 14,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: backColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
      ),
    );
  }
}
