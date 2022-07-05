import 'package:flutter/cupertino.dart'
  show ChangeNotifier, CupertinoThemeData, Brightness;

import 'package:flutterfly/share_preferences/preferences.dart';

class ThemeCupertinoProvider extends ChangeNotifier {

  CupertinoThemeData currentTheme;
  bool darkState;

  ThemeCupertinoProvider({required bool isDarkmode, required this.darkState}):
    currentTheme = isDarkmode
      ? const CupertinoThemeData(brightness: Brightness.dark)
      : const CupertinoThemeData(brightness: Brightness.light);

  void toggle() {
    darkState = !darkState;
    Preferences.isDarkmode = darkState;
    darkState
      ? currentTheme = const CupertinoThemeData(brightness: Brightness.dark)
      : currentTheme = const CupertinoThemeData(brightness: Brightness.light);
    notifyListeners();
  }
}