import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';


class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final Color borderColor;
  final Color textColor;
  final Color cursorColor;
  final Color backColor;
  final double borderRadius;
  final double fontSize;
  final TextInputType keyboardType;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon = Icons.input,
    this.borderColor = black,
    this.textColor = black,
    this.cursorColor = black,
    this.backColor = white,
    this.borderRadius = 30.0,
    this.fontSize = 16.0,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Icon(
            icon,
            color: textColor,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                hintText: hintText,
                hintStyle: TextStyle(color: textColor, fontSize: fontSize),
                border: InputBorder.none,
              ),
              keyboardType: keyboardType,
              style: TextStyle(color: textColor, fontSize: fontSize),
              cursorColor: cursorColor,
            ),
          ),
        ],
      ),
    );
  }
}
