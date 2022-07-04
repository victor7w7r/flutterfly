import 'dart:io' show SocketException;

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutterfly/models/binance.dart';

class BinanceProvider extends ChangeNotifier {

  final _baseUrl  = 'api2.binance.com';

  List<Binance> allBin = [];
  List<Binance> bin = [];
  int position = 0;
  bool loading = true;

  BinanceProvider() {
    getCurrencies();
  }

  Future<String> _getJsonData(String endpoint) async {
    try {
      final url = Uri.https( _baseUrl, endpoint );
      final response = await http.get(url);
      return response.body;
    } on SocketException catch (_) {
      return '';
    }
  }

  getCurrencies() async {
    final jsonData = await _getJsonData('/api/v3/ticker/24hr');
    final binData = Binance.fromJsonList(jsonData);
    allBin = binData;
    try {
      bin = binData.sublist(0, 40);
      position = 40;
      loading = false;
      notifyListeners();
    }  on RangeError catch (_) { }
  }

  void paginateCurrencies () {
    loading = true;
    bin = allBin.sublist(0, position + 40);
    position += 40;
    loading = false;
    notifyListeners();
  }

}