import 'package:flutter/widgets.dart';

class DataProvider extends ChangeNotifier {

  DataProvider({required this.data});

  String data;

  void rename(String reciever) {
    data = reciever;
    notifyListeners();
  }

}