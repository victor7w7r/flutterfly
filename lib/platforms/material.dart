import 'package:flutter/material.dart';

MaterialApp materialApp(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'flutterfly',
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    home: const Center(
      child: Text('Awesome')
    )
  );
}