// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Binance _$$_BinanceFromJson(Map<String, dynamic> json) => _$_Binance(
      json['symbol'] as String,
      json['priceChange'] as String,
      json['priceChangePercent'] as String,
      json['weightedAvgPrice'] as String,
      json['prevClosePrice'] as String,
      json['lastPrice'] as String,
      json['lastQty'] as String,
      json['bidPrice'] as String,
      json['bidQty'] as String,
      json['askPrice'] as String,
      json['askQty'] as String,
      json['openPrice'] as String,
      json['highPrice'] as String,
      json['lowPrice'] as String,
      json['volume'] as String,
      json['quoteVolume'] as String,
      (json['openTime'] as num).toDouble(),
      (json['closeTime'] as num).toDouble(),
      (json['firstId'] as num).toDouble(),
      (json['lastId'] as num).toDouble(),
      (json['count'] as num).toDouble(),
    );

Map<String, dynamic> _$$_BinanceToJson(_$_Binance instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'priceChange': instance.priceChange,
      'priceChangePercent': instance.priceChangePercent,
      'weightedAvgPrice': instance.weightedAvgPrice,
      'prevClosePrice': instance.prevClosePrice,
      'lastPrice': instance.lastPrice,
      'lastQty': instance.lastQty,
      'bidPrice': instance.bidPrice,
      'bidQty': instance.bidQty,
      'askPrice': instance.askPrice,
      'askQty': instance.askQty,
      'openPrice': instance.openPrice,
      'highPrice': instance.highPrice,
      'lowPrice': instance.lowPrice,
      'volume': instance.volume,
      'quoteVolume': instance.quoteVolume,
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
      'firstId': instance.firstId,
      'lastId': instance.lastId,
      'count': instance.count,
    };
