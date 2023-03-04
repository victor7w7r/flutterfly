import 'package:fpdart/fpdart.dart' show Either;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'binance.freezed.dart';
part 'binance.g.dart';

@freezed
class Binance with _$Binance {

  const factory Binance(
    String symbol, String priceChange, String priceChangePercent,
    String weightedAvgPrice, String prevClosePrice,
    String lastPrice, String lastQty, String bidPrice,
    String bidQty, String askPrice, String askQty,
    String openPrice, String highPrice, String lowPrice,
    String volume, String quoteVolume, double openTime,
    double closeTime, double firstId,
    double lastId, double count
  ) = _Binance;

  factory Binance.fromJson(Map<String, dynamic> json) => _$BinanceFromJson(json);

  static List<Binance> dummyGen() => List.filled(120, null).map((_) => const Binance(
    'Dummy', '', '0.00', '',
    '', '', '', '100', '', '',
    '', '', '', '', '', '', 0,
    0, 0, 0, 0
  )).toList();

  static List<Binance> fromJsonToList(List<dynamic> list) => Either.tryCatch(
    () => list.map((e) => Binance.fromJson(e)).toList(),
    (e, _) => e
  ).getOrElse((_) => []);
}