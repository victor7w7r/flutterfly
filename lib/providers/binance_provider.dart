import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutterfly/models/binance.dart';

class BinanceProvider extends ChangeNotifier {

  final _baseUrl  = 'api2.binance.com';

  List<Binance> allBin = [];
  List<Binance> bin = [];
  int position = 0;
  bool loading = true;

  BinanceProvider() {
    getCurrencies ();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https( _baseUrl, endpoint );
    final response = await http.get(url);
    return response.body;
  }
  
  getCurrencies() async {
    final jsonData = await _getJsonData('/api/v3/ticker/24hr');
    final binData = Binance.fromJsonList(jsonData);
    allBin = binData;
    bin = binData.sublist(0, 40);
    position = 40;
    loading = false;
    notifyListeners();
  }

  void paginateCurrencies () {
    loading = true;
    bin = allBin.sublist(0, position + 40);
    position += 40;
    loading = false;
    notifyListeners();
  }

}