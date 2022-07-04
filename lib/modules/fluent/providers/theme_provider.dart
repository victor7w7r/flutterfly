import 'dart:async';

import 'package:flutter/widgets.dart';

class ThemeFluentProvider extends ChangeNotifier {

  ThemeFluentProvider({
    required this.darkMode,
    required this.backgroundColor,
    required this.cardColor,
    required this.invertedColor,
  });

  bool darkMode;
  Color backgroundColor;
  Color cardColor;
  Color invertedColor;

  void interpolator(Color changer, String selector) {
    double linear = 0.1;
    Timer.periodic(const Duration(milliseconds: 30), (t) {
      switch(selector) {
        case 'background':
          backgroundColor = Color.lerp(backgroundColor, changer, linear)!;
          break;
        case 'card':
          cardColor = Color.lerp(cardColor, changer, linear)!;
          break;
        case 'color':
          invertedColor = Color.lerp(invertedColor, changer, linear)!;
          break;
      }
      linear += 0.1;
      notifyListeners();
      if(linear >= 1) {
        t.cancel();
      }
    });
  }

  void toggle(bool value) {
    darkMode = value;
    if(darkMode) {
      interpolator(const Color(0xFF18171C), 'background');
      interpolator(const Color(0xFF20242D), 'card');
      interpolator(const Color(0xFFFFFFFF), 'color');
    } else {
      interpolator(const Color(0xFFFFFFFF), 'background');
      interpolator(const Color(0xFFC1C6CC), 'card');
      interpolator(const Color(0xFF000000), 'color');
    }
  }
}