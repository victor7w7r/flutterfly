import 'dart:convert' show json;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

part 'binance.g.dart';

@JsonSerializable()
class Binance {

  Binance(
    this.symbol, this.priceChange, this.priceChangePercent,
    this.weightedAvgPrice, this.prevClosePrice,
    this.lastPrice, this.lastQty, this.bidPrice,
    this.bidQty, this.askPrice, this.askQty,
    this.openPrice, this.highPrice, this.lowPrice,
    this.volume, this.quoteVolume, this.openTime,
    this.closeTime, this.firstId,
    this.lastId, this.count,
  );

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

  factory Binance.fromJson(Map<String, dynamic> json) => _$BinanceFromJson(json);
  Map<String, dynamic> toJson() => _$BinanceToJson(this);

  static List<Binance> fromJsonList(String str) {
    return (json.decode(str) as List).map((data) => Binance.fromJson(data)).toList();
  }

}