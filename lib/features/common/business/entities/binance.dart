import 'package:equatable/equatable.dart';

base class Binance extends Equatable {
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

  @override
  List<Object> get props => [
        symbol,
        priceChange,
        priceChangePercent,
        weightedAvgPrice,
        prevClosePrice,
        lastPrice,
        lastQty,
        bidPrice,
        bidQty,
        askPrice,
        askQty,
        openPrice,
        highPrice,
        lowPrice,
        volume,
        quoteVolume,
        openTime,
        closeTime,
        firstId,
        lastId,
        count,
      ];

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
