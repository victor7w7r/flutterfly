import 'package:flutter/cupertino.dart'
  show ChangeNotifier, CupertinoThemeData, Brightness;

import 'package:flutterfly/share_preferences/preferences.dart';

class ThemeCupertinoProvider extends ChangeNotifier {

  CupertinoThemeData currentTheme;
  bool darkMode;

  ThemeCupertinoProvider({required bool isDarkmode, required this.darkMode}):
    currentTheme = isDarkmode
      ? const CupertinoThemeData(brightness: Brightness.dark)
      : const CupertinoThemeData(brightness: Brightness.light);

  void toggle() {
    darkMode = !darkMode;
    Preferences.darkModeCupertino = darkMode;
    darkMode
      ? currentTheme = const CupertinoThemeData(brightness: Brightness.dark)
      : currentTheme = const CupertinoThemeData(brightness: Brightness.light);
    notifyListeners();
  }
}