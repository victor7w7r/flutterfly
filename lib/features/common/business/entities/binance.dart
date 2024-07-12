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

  final String askPrice;
  final String askQty;
  final String bidPrice;
  final String bidQty;
  final double closeTime;
  final double count;
  final double firstId;
  final String highPrice;
  final double lastId;
  final String lastPrice;
  final String lastQty;
  final String lowPrice;
  final String openPrice;
  final double openTime;
  final String prevClosePrice;
  final String priceChange;
  final String priceChangePercent;
  final String quoteVolume;
  final String symbol;
  final String volume;
  final String weightedAvgPrice;

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
