import 'package:flutter/material.dart';

extension MediaQueryExt on BuildContext {
  double get mWidth => MediaQuery.sizeOf(this).width;
  double get mHeight => MediaQuery.sizeOf(this).height;
  bool get isMaxMd => MediaQuery.sizeOf(this).width > 720;
  bool get isMinMd => MediaQuery.sizeOf(this).width < 720;
  bool get isMaxLg => MediaQuery.sizeOf(this).width > 960;
  bool get isMaxResp => MediaQuery.sizeOf(this).width > 890;
  bool get isBRatio => MediaQuery.devicePixelRatioOf(this) >= 3.0;
  bool get isMRatio => MediaQuery.devicePixelRatioOf(this) >= 2.0;
}
