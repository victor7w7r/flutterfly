import 'package:flutter/widgets.dart' show ChangeNotifier;

class DataProvider extends ChangeNotifier {

  DataProvider({required this.data});

  String data;

  void rename(String reciever) {
    data = reciever;
    notifyListeners();
  }
}