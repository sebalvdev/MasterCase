import 'package:flutter/material.dart';

class CustomeInput extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final double height;
  final Color borderColor;
  final Color cursorColor;
  final Color textColor;
  final Color hintTextColor;
  final String hintText;
  final IconData icon;
  final Color iconColor;
  final Color backColor;
  final double borderRadius;
  final double fontSize;
  final bool numeric;

  const CustomeInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.width = 300,
    this.height = 50,
    this.borderColor = Colors.black,
    this.cursorColor = Colors.black,
    this.textColor = Colors.black,
    this.hintTextColor = Colors.black,
    this.icon = Icons.phone_android_sharp,
    this.iconColor = Colors.black,
    this.backColor = Colors.white,
    this.borderRadius = 30,
    this.fontSize = 16,
    this.numeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
        color: backColor,
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Icon(icon, color: iconColor),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                hintText: hintText,
                hintStyle: TextStyle(color: hintTextColor, fontSize: fontSize),
                border: InputBorder.none,
              ),
              keyboardType: numeric ? TextInputType.number : TextInputType.text,
              style: TextStyle(color: textColor, fontSize: fontSize),
              cursorColor: cursorColor,
            ),
          ),
        ],
      ),
    );
  }
}
