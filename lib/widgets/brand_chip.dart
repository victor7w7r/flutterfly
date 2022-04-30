import 'package:flutter/material.dart';

Widget brandChip(bool value) {

  return Container(
    width: 275,
    height: 50,
    child: Row(
      children: [
        const SizedBox(width: 30),
        Image.asset( value ? 'assets/brandwhite.png' : 'assets/brand.png', width: 220.0, height: 43.0),
      ]
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      border: value
              ? Border.all(width: 2, color: Colors.white)
              : Border.all(width: 2, color: Colors.black)
    ),
  );
}