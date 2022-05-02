import 'package:flutter/material.dart';

Container logoChip(bool value) {

  return Container(
    width: 270,
    height: 50,
    child: Row(
      children: [
        Image.asset('assets/flutter-logo.png', width: 58.0, height: 35.0),
        const Text('Flutter Material Template', style: TextStyle(fontSize: 20))
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