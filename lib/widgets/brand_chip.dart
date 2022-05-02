import 'package:flutter/material.dart';

Container brandChip(bool value) {

  return Container(
    width: 300,
    height: 70,
    child: Row(
      children: [
        const SizedBox(width: 38),
        Image.asset(value ? 'assets/brandwhite.png' : 'assets/brand.png', width: 220.0, height: 70.0)
      ]
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      border: value
              ? Border.all(width: 2, color: Colors.white)
              : Border.all(width: 2, color: Colors.black)
    )
  );
}