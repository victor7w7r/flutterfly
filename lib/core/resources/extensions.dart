import 'package:flutter/material.dart';

extension MediaQueryExt on BuildContext {
  double get mWidth => MediaQuery.of(this).size.width;
  double get mHeight => MediaQuery.of(this).size.height;
  bool get maxMd => MediaQuery.of(this).size.width > 720;
  bool get minMd => MediaQuery.of(this).size.width < 720;
  bool get maxLg => MediaQuery.of(this).size.width > 960;
  bool get maxResp => MediaQuery.of(this).size.width > 890;
  bool get bRatio => MediaQuery.of(this).devicePixelRatio >= 3.0;
  bool get mRatio => MediaQuery.of(this).devicePixelRatio >= 2.0;
}
