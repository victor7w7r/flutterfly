import 'package:dart_mappable/dart_mappable.dart';

part '../../../../generated/features/common/business/entities/binance.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
base class Binance with BinanceMappable {
  const Binance(
    this.symbol,
    this.priceChange,
    this.priceChangePercent,
    this.weightedAvgPrice,
    this.prevClosePrice,
    this.lastPrice,
    this.lastQty,
    this.bidPrice,
    this.bidQty,
    this.askPrice,
    this.askQty,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.volume,
    this.quoteVolume,
    this.openTime,
    this.closeTime,
    this.firstId,
    this.lastId,
    this.count,
  );

  factory Binance.detached() => const Binance(
        'Detached',
        '',
        '0.00',
        '',
        '',
        '',
        '',
        '100',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
      );

  final String symbol;
  final String priceChange;
  final String priceChangePercent;
  final String weightedAvgPrice;
  final String prevClosePrice;
  final String lastPrice;
  final String lastQty;
  final String bidPrice;
  final String bidQty;
  final String askPrice;
  final String askQty;
  final String openPrice;
  final String highPrice;
  final String lowPrice;
  final String volume;
  final String quoteVolume;
  final double openTime;
  final double closeTime;
  final double firstId;
  final double lastId;
  final double count;

  static List<Binance> dummyGen() => List.filled(120, null)
      .map(
        (final _) => const Binance(
          'Dummy',
          '',
          '0.00',
          '',
          '',
          '',
          '',
          '100',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          0,
          0,
          0,
          0,
          0,
        ),
      )
      .toList();
}
