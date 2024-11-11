import 'package:flutter/material.dart';

Row cards(double imagewith) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: imagewith,
              child: Image.asset('assets/images/cocina.jpg', fit: BoxFit.contain,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: imagewith,
              child: Image.asset('assets/images/cocina.jpg', fit: BoxFit.contain,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: imagewith,
              child: Image.asset('assets/images/cocina.jpg', fit: BoxFit.contain,),
            ),
          ),
        ],
      );
  }