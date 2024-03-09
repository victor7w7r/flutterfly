// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../../../../../features/common/data/dto/binance_dto.dart';

class BinanceDtoMapper extends ClassMapperBase<BinanceDto> {
  BinanceDtoMapper._();

  static BinanceDtoMapper? _instance;
  static BinanceDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BinanceDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BinanceDto';

  static String _$symbol(BinanceDto v) => v.symbol;
  static const Field<BinanceDto, String> _f$symbol = Field('symbol', _$symbol);
  static String _$priceChange(BinanceDto v) => v.priceChange;
  static const Field<BinanceDto, String> _f$priceChange =
      Field('priceChange', _$priceChange);
  static String _$priceChangePercent(BinanceDto v) => v.priceChangePercent;
  static const Field<BinanceDto, String> _f$priceChangePercent =
      Field('priceChangePercent', _$priceChangePercent);
  static String _$weightedAvgPrice(BinanceDto v) => v.weightedAvgPrice;
  static const Field<BinanceDto, String> _f$weightedAvgPrice =
      Field('weightedAvgPrice', _$weightedAvgPrice);
  static String _$prevClosePrice(BinanceDto v) => v.prevClosePrice;
  static const Field<BinanceDto, String> _f$prevClosePrice =
      Field('prevClosePrice', _$prevClosePrice);
  static String _$lastPrice(BinanceDto v) => v.lastPrice;
  static const Field<BinanceDto, String> _f$lastPrice =
      Field('lastPrice', _$lastPrice);
  static String _$lastQty(BinanceDto v) => v.lastQty;
  static const Field<BinanceDto, String> _f$lastQty =
      Field('lastQty', _$lastQty);
  static String _$bidPrice(BinanceDto v) => v.bidPrice;
  static const Field<BinanceDto, String> _f$bidPrice =
      Field('bidPrice', _$bidPrice);
  static String _$bidQty(BinanceDto v) => v.bidQty;
  static const Field<BinanceDto, String> _f$bidQty = Field('bidQty', _$bidQty);
  static String _$askPrice(BinanceDto v) => v.askPrice;
  static const Field<BinanceDto, String> _f$askPrice =
      Field('askPrice', _$askPrice);
  static String _$askQty(BinanceDto v) => v.askQty;
  static const Field<BinanceDto, String> _f$askQty = Field('askQty', _$askQty);
  static String _$openPrice(BinanceDto v) => v.openPrice;
  static const Field<BinanceDto, String> _f$openPrice =
      Field('openPrice', _$openPrice);
  static String _$highPrice(BinanceDto v) => v.highPrice;
  static const Field<BinanceDto, String> _f$highPrice =
      Field('highPrice', _$highPrice);
  static String _$lowPrice(BinanceDto v) => v.lowPrice;
  static const Field<BinanceDto, String> _f$lowPrice =
      Field('lowPrice', _$lowPrice);
  static String _$volume(BinanceDto v) => v.volume;
  static const Field<BinanceDto, String> _f$volume = Field('volume', _$volume);
  static String _$quoteVolume(BinanceDto v) => v.quoteVolume;
  static const Field<BinanceDto, String> _f$quoteVolume =
      Field('quoteVolume', _$quoteVolume);
  static double _$openTime(BinanceDto v) => v.openTime;
  static const Field<BinanceDto, double> _f$openTime =
      Field('openTime', _$openTime);
  static double _$closeTime(BinanceDto v) => v.closeTime;
  static const Field<BinanceDto, double> _f$closeTime =
      Field('closeTime', _$closeTime);
  static double _$firstId(BinanceDto v) => v.firstId;
  static const Field<BinanceDto, double> _f$firstId =
      Field('firstId', _$firstId);
  static double _$lastId(BinanceDto v) => v.lastId;
  static const Field<BinanceDto, double> _f$lastId = Field('lastId', _$lastId);
  static double _$count(BinanceDto v) => v.count;
  static const Field<BinanceDto, double> _f$count = Field('count', _$count);

  @override
  final MappableFields<BinanceDto> fields = const {
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

  static BinanceDto _instantiate(DecodingData data) {
    return BinanceDto(
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

  static BinanceDto fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BinanceDto>(map);
  }

  static BinanceDto fromJsonString(String json) {
    return ensureInitialized().decodeJson<BinanceDto>(json);
  }
}

mixin BinanceDtoMappable {
  String toJsonString() {
    return BinanceDtoMapper.ensureInitialized()
        .encodeJson<BinanceDto>(this as BinanceDto);
  }

  Map<String, dynamic> toJson() {
    return BinanceDtoMapper.ensureInitialized()
        .encodeMap<BinanceDto>(this as BinanceDto);
  }

  BinanceDtoCopyWith<BinanceDto, BinanceDto, BinanceDto> get copyWith =>
      _BinanceDtoCopyWithImpl(this as BinanceDto, $identity, $identity);
  @override
  String toString() {
    return BinanceDtoMapper.ensureInitialized()
        .stringifyValue(this as BinanceDto);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BinanceDtoMapper.ensureInitialized()
                .isValueEqual(this as BinanceDto, other));
  }

  @override
  int get hashCode {
    return BinanceDtoMapper.ensureInitialized().hashValue(this as BinanceDto);
  }
}

extension BinanceDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BinanceDto, $Out> {
  BinanceDtoCopyWith<$R, BinanceDto, $Out> get $asBinanceDto =>
      $base.as((v, t, t2) => _BinanceDtoCopyWithImpl(v, t, t2));
}

abstract class BinanceDtoCopyWith<$R, $In extends BinanceDto, $Out>
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
  BinanceDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BinanceDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BinanceDto, $Out>
    implements BinanceDtoCopyWith<$R, BinanceDto, $Out> {
  _BinanceDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BinanceDto> $mapper =
      BinanceDtoMapper.ensureInitialized();
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
  BinanceDto $make(CopyWithData data) => BinanceDto(
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
  BinanceDtoCopyWith<$R2, BinanceDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BinanceDtoCopyWithImpl($value, $cast, t);
}
