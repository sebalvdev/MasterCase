import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class CustomDropdownButton extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final List<String> items;
  final String? selectedValue;
  final Color color;
  final Color dropdownColor;
  final Color textColor;
  final double fontSize;
  final ValueChanged<String?> onChanged;
  final bool border;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.width = 200,
    this.height = 50,
    this.hintText = 'Opciones',
    this.selectedValue,
    this.color = white,
    this.dropdownColor = white,
    this.textColor = black,
    this.fontSize = 14,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: border ? textColor : color),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: DropdownButtonFormField<String>(
          iconEnabledColor: textColor,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          hint: Center(
            child: Text(
              hintText,
              style: TextStyle(color: textColor, fontSize: fontSize),
              textAlign: TextAlign.center,
            ),
          ),
          value: selectedValue,
          dropdownColor: dropdownColor,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              alignment: Alignment.center,
              child: Text(
                value,
                style: TextStyle(color: textColor, fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
