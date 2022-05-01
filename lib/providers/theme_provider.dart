import 'package:flutter/material.dart';

import 'package:flutterfly/share_preferences/preferences.dart';

class ThemeProvider extends ChangeNotifier{ 

  bool darkState;
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkmode, required this.darkState}):
    currentTheme = isDarkmode 
      ? ThemeData.dark() 
      : ThemeData.light();

  void toggle() {   
    darkState = !darkState;
    Preferences.isDarkmode = darkState;
    darkState 
      ? currentTheme = ThemeData.dark()
      : currentTheme = ThemeData.light();
    notifyListeners();
  }
}