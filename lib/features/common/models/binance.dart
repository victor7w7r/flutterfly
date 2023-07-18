import 'package:fpdart/fpdart.dart' show Either;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'binance.freezed.dart';
part 'binance.g.dart';

@freezed
class Binance with _$Binance {

  const factory Binance(
    final String symbol, final String priceChange,
    final String priceChangePercent,
    final String weightedAvgPrice, final String prevClosePrice,
    final String lastPrice, final String lastQty,
    final String bidPrice, final String bidQty,
    final String askPrice, final String askQty,
    final String openPrice, final String highPrice,
    final String lowPrice, final String volume,
    final String quoteVolume, final double openTime,
    final double closeTime, final double firstId,
    final double lastId, final double count
  ) = _Binance;

  factory Binance.fromJson(
    final Map<String, dynamic> json
  ) => _$BinanceFromJson(json);

  static List<Binance> dummyGen() =>
    List.filled(120, null).map((final _) => const Binance(
      'Dummy', '', '0.00', '',
      '', '', '', '100', '', '',
      '', '', '', '', '', '', 0,
      0, 0, 0, 0
    )).toList();

  static List<Binance> fromJsonToList(
    final List<dynamic> list
  ) => Either.tryCatch(
    // ignore: unnecessary_lambdas
    () => list.map((final curr) => Binance.fromJson(curr)).toList(),
    (final e, final _) => e
  ).getOrElse((final _) => []);
}