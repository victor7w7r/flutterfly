import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {

  DataProvider({this.data}); 

  String? data;

  void rename( String reciever ) {
    data = reciever;
    notifyListeners();
  }

}