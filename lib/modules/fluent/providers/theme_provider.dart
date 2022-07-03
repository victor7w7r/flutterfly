import 'package:flutter/widgets.dart';


class ThemeFluentProvider extends ChangeNotifier {

  ThemeFluentProvider({required this.color, required this.darkState});

  Color color;
  bool darkState;

  void toggle() {
    darkState = !darkState;
    notifyListeners();
  }
}