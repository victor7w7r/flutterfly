// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../../../../../features/common/business/entities/binance.dart';

class BinanceMapper extends ClassMapperBase<Binance> {
  BinanceMapper._();

  static BinanceMapper? _instance;
  static BinanceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BinanceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Binance';

  static String _$symbol(Binance v) => v.symbol;
  static const Field<Binance, String> _f$symbol = Field('symbol', _$symbol);
  static String _$priceChange(Binance v) => v.priceChange;
  static const Field<Binance, String> _f$priceChange =
      Field('priceChange', _$priceChange);
  static String _$priceChangePercent(Binance v) => v.priceChangePercent;
  static const Field<Binance, String> _f$priceChangePercent =
      Field('priceChangePercent', _$priceChangePercent);
  static String _$weightedAvgPrice(Binance v) => v.weightedAvgPrice;
  static const Field<Binance, String> _f$weightedAvgPrice =
      Field('weightedAvgPrice', _$weightedAvgPrice);
  static String _$prevClosePrice(Binance v) => v.prevClosePrice;
  static const Field<Binance, String> _f$prevClosePrice =
      Field('prevClosePrice', _$prevClosePrice);
  static String _$lastPrice(Binance v) => v.lastPrice;
  static const Field<Binance, String> _f$lastPrice =
      Field('lastPrice', _$lastPrice);
  static String _$lastQty(Binance v) => v.lastQty;
  static const Field<Binance, String> _f$lastQty = Field('lastQty', _$lastQty);
  static String _$bidPrice(Binance v) => v.bidPrice;
  static const Field<Binance, String> _f$bidPrice =
      Field('bidPrice', _$bidPrice);
  static String _$bidQty(Binance v) => v.bidQty;
  static const Field<Binance, String> _f$bidQty = Field('bidQty', _$bidQty);
  static String _$askPrice(Binance v) => v.askPrice;
  static const Field<Binance, String> _f$askPrice =
      Field('askPrice', _$askPrice);
  static String _$askQty(Binance v) => v.askQty;
  static const Field<Binance, String> _f$askQty = Field('askQty', _$askQty);
  static String _$openPrice(Binance v) => v.openPrice;
  static const Field<Binance, String> _f$openPrice =
      Field('openPrice', _$openPrice);
  static String _$highPrice(Binance v) => v.highPrice;
  static const Field<Binance, String> _f$highPrice =
      Field('highPrice', _$highPrice);
  static String _$lowPrice(Binance v) => v.lowPrice;
  static const Field<Binance, String> _f$lowPrice =
      Field('lowPrice', _$lowPrice);
  static String _$volume(Binance v) => v.volume;
  static const Field<Binance, String> _f$volume = Field('volume', _$volume);
  static String _$quoteVolume(Binance v) => v.quoteVolume;
  static const Field<Binance, String> _f$quoteVolume =
      Field('quoteVolume', _$quoteVolume);
  static double _$openTime(Binance v) => v.openTime;
  static const Field<Binance, double> _f$openTime =
      Field('openTime', _$openTime);
  static double _$closeTime(Binance v) => v.closeTime;
  static const Field<Binance, double> _f$closeTime =
      Field('closeTime', _$closeTime);
  static double _$firstId(Binance v) => v.firstId;
  static const Field<Binance, double> _f$firstId = Field('firstId', _$firstId);
  static double _$lastId(Binance v) => v.lastId;
  static const Field<Binance, double> _f$lastId = Field('lastId', _$lastId);
  static double _$count(Binance v) => v.count;
  static const Field<Binance, double> _f$count = Field('count', _$count);

  @override
  final MappableFields<Binance> fields = const {
    #symbol: _f$symbol,
    #priceChange: _f$priceChange,
    #priceChangePercent: _f$priceChangePercent,
    #weightedAvgPrice: _f$weightedAvgPrice,
    #prevClosePrice: _f$prevClosePrice,
    #lastPrice: _f$lastPrice,
    #lastQty: _f$lastQty,
    #bidPrice: _f$bidPrice,
    #bidQty: _f$bidQty,
    #askPrice: _f$askPrice,
    #askQty: _f$askQty,
    #openPrice: _f$openPrice,
    #highPrice: _f$highPrice,
    #lowPrice: _f$lowPrice,
    #volume: _f$volume,
    #quoteVolume: _f$quoteVolume,
    #openTime: _f$openTime,
    #closeTime: _f$closeTime,
    #firstId: _f$firstId,
    #lastId: _f$lastId,
    #count: _f$count,
  };

  static Binance _instantiate(DecodingData data) {
    return Binance(
        data.dec(_f$symbol),
        data.dec(_f$priceChange),
        data.dec(_f$priceChangePercent),
        data.dec(_f$weightedAvgPrice),
        data.dec(_f$prevClosePrice),
        data.dec(_f$lastPrice),
        data.dec(_f$lastQty),
        data.dec(_f$bidPrice),
        data.dec(_f$bidQty),
        data.dec(_f$askPrice),
        data.dec(_f$askQty),
        data.dec(_f$openPrice),
        data.dec(_f$highPrice),
        data.dec(_f$lowPrice),
        data.dec(_f$volume),
        data.dec(_f$quoteVolume),
        data.dec(_f$openTime),
        data.dec(_f$closeTime),
        data.dec(_f$firstId),
        data.dec(_f$lastId),
        data.dec(_f$count));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin BinanceMappable {
  BinanceCopyWith<Binance, Binance, Binance> get copyWith =>
      _BinanceCopyWithImpl(this as Binance, $identity, $identity);
  @override
  String toString() {
    return BinanceMapper.ensureInitialized().stringifyValue(this as Binance);
  }

  @override
  bool operator ==(Object other) {
    return BinanceMapper.ensureInitialized()
        .equalsValue(this as Binance, other);
  }

  @override
  int get hashCode {
    return BinanceMapper.ensureInitialized().hashValue(this as Binance);
  }
}

extension BinanceValueCopy<$R, $Out> on ObjectCopyWith<$R, Binance, $Out> {
  BinanceCopyWith<$R, Binance, $Out> get $asBinance =>
      $base.as((v, t, t2) => _BinanceCopyWithImpl(v, t, t2));
}

abstract class BinanceCopyWith<$R, $In extends Binance, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? symbol,
      String? priceChange,
      String? priceChangePercent,
      String? weightedAvgPrice,
      String? prevClosePrice,
      String? lastPrice,
      String? lastQty,
      String? bidPrice,
      String? bidQty,
      String? askPrice,
      String? askQty,
      String? openPrice,
      String? highPrice,
      String? lowPrice,
      String? volume,
      String? quoteVolume,
      double? openTime,
      double? closeTime,
      double? firstId,
      double? lastId,
      double? count});
  BinanceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BinanceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Binance, $Out>
    implements BinanceCopyWith<$R, Binance, $Out> {
  _BinanceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Binance> $mapper =
      BinanceMapper.ensureInitialized();
  @override
  $R call(
          {String? symbol,
          String? priceChange,
          String? priceChangePercent,
          String? weightedAvgPrice,
          String? prevClosePrice,
          String? lastPrice,
          String? lastQty,
          String? bidPrice,
          String? bidQty,
          String? askPrice,
          String? askQty,
          String? openPrice,
          String? highPrice,
          String? lowPrice,
          String? volume,
          String? quoteVolume,
          double? openTime,
          double? closeTime,
          double? firstId,
          double? lastId,
          double? count}) =>
      $apply(FieldCopyWithData({
        if (symbol != null) #symbol: symbol,
        if (priceChange != null) #priceChange: priceChange,
        if (priceChangePercent != null) #priceChangePercent: priceChangePercent,
        if (weightedAvgPrice != null) #weightedAvgPrice: weightedAvgPrice,
        if (prevClosePrice != null) #prevClosePrice: prevClosePrice,
        if (lastPrice != null) #lastPrice: lastPrice,
        if (lastQty != null) #lastQty: lastQty,
        if (bidPrice != null) #bidPrice: bidPrice,
        if (bidQty != null) #bidQty: bidQty,
        if (askPrice != null) #askPrice: askPrice,
        if (askQty != null) #askQty: askQty,
        if (openPrice != null) #openPrice: openPrice,
        if (highPrice != null) #highPrice: highPrice,
        if (lowPrice != null) #lowPrice: lowPrice,
        if (volume != null) #volume: volume,
        if (quoteVolume != null) #quoteVolume: quoteVolume,
        if (openTime != null) #openTime: openTime,
        if (closeTime != null) #closeTime: closeTime,
        if (firstId != null) #firstId: firstId,
        if (lastId != null) #lastId: lastId,
        if (count != null) #count: count
      }));
  @override
  Binance $make(CopyWithData data) => Binance(
      data.get(#symbol, or: $value.symbol),
      data.get(#priceChange, or: $value.priceChange),
      data.get(#priceChangePercent, or: $value.priceChangePercent),
      data.get(#weightedAvgPrice, or: $value.weightedAvgPrice),
      data.get(#prevClosePrice, or: $value.prevClosePrice),
      data.get(#lastPrice, or: $value.lastPrice),
      data.get(#lastQty, or: $value.lastQty),
      data.get(#bidPrice, or: $value.bidPrice),
      data.get(#bidQty, or: $value.bidQty),
      data.get(#askPrice, or: $value.askPrice),
      data.get(#askQty, or: $value.askQty),
      data.get(#openPrice, or: $value.openPrice),
      data.get(#highPrice, or: $value.highPrice),
      data.get(#lowPrice, or: $value.lowPrice),
      data.get(#volume, or: $value.volume),
      data.get(#quoteVolume, or: $value.quoteVolume),
      data.get(#openTime, or: $value.openTime),
      data.get(#closeTime, or: $value.closeTime),
      data.get(#firstId, or: $value.firstId),
      data.get(#lastId, or: $value.lastId),
      data.get(#count, or: $value.count));

  @override
  BinanceCopyWith<$R2, Binance, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BinanceCopyWithImpl($value, $cast, t);
}
