import 'package:flutter/material.dart' show ChangeNotifier, ThemeData;

import 'package:flutterfly/share_preferences/preferences.dart';

class ThemeMaterialProvider extends ChangeNotifier{

  ThemeData currentTheme;
  bool darkState;

  ThemeMaterialProvider({required bool isDarkmode, required this.darkState}):
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