import 'dart:convert';

class Binance {

  Binance({
    required this.symbol, required this.priceChange, required this.priceChangePercent,
    required this.weightedAvgPrice, required this.prevClosePrice,
    required this.lastPrice, required this.lastQty, required this.bidPrice,
    required this.bidQty, required this.askPrice, required this.askQty,
    required this.openPrice, required this.highPrice, required this.lowPrice,
    required this.volume, required this.quoteVolume, required this.openTime,
    required this.closeTime, required this.firstId,
    required this.lastId, required this.count,
  });

  String symbol;
  String priceChange;
  String priceChangePercent;
  String weightedAvgPrice;
  String prevClosePrice;
  String lastPrice;
  String lastQty;
  String bidPrice;
  String bidQty;
  String askPrice;
  String askQty;
  String openPrice;
  String highPrice;
  String lowPrice;
  String volume;
  String quoteVolume;
  double openTime;
  double closeTime;
  double firstId;
  double lastId;
  double count;

  factory Binance.fromMap(Map<String, dynamic> json) => Binance(
    symbol: json["symbol"],
    priceChange: json["priceChange"],
    priceChangePercent: json["priceChangePercent"],
    weightedAvgPrice: json["weightedAvgPrice"],
    prevClosePrice: json["prevClosePrice"],
    lastPrice: json["lastPrice"],
    lastQty: json["lastQty"],
    bidPrice: json["bidPrice"],
    bidQty: json["bidQty"],
    askPrice: json["askPrice"],
    askQty: json["askQty"],
    openPrice: json["openPrice"],
    highPrice: json["highPrice"],
    lowPrice: json["lowPrice"],
    volume: json["volume"],
    quoteVolume: json["quoteVolume"],
    openTime: json["openTime"].toDouble(),
    closeTime: json["closeTime"].toDouble(),
    firstId: json["firstId"].toDouble(),
    lastId: json["lastId"].toDouble(),
    count: json["count"].toDouble()
  );

  static List<Binance> fromJsonList(String str) {
    return (json.decode(str) as List).map((data) => Binance.fromMap(data)).toList();
  }

}