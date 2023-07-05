import 'package:flutter/material.dart';

extension MediaQueryExt on BuildContext {
  double get mWidth => MediaQuery.of(this).size.width;
  double get mHeight => MediaQuery.of(this).size.height;
}