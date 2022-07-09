import 'package:flutter/material.dart' show ChangeNotifier, ThemeData;

import 'package:flutterfly/share_preferences/preferences.dart';

class MaterialProvider extends ChangeNotifier{

  ThemeData currentTheme;
  bool darkMode;

  MaterialProvider({required bool isDarkmode, required this.darkMode}):
    currentTheme = isDarkmode ? ThemeData.dark() : ThemeData.light();

  void toggle() {
    darkMode = !darkMode;
    Preferences.darkModeMaterial = darkMode;
    darkMode
      ? currentTheme = ThemeData.dark()
      : currentTheme = ThemeData.light();
    notifyListeners();
  }
}