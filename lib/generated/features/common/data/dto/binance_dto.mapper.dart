// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '../../../../../features/common/data/dto/binance_dto.dart';

class BinanceDtoMapper extends ClassMapperBase<BinanceDto> {
  BinanceDtoMapper._();

  static BinanceDtoMapper? _instance;
  static BinanceDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BinanceDtoMapper._());
      BinanceMapper.ensureInitialized();
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
}
