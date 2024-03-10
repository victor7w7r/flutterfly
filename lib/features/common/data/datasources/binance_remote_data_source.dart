import 'package:flutter/foundation.dart' show compute;

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flutterfly/features/common/data/dto/dto.dart';

part '../../../../generated/features/common/data/datasources/binance_remote_data_source.g.dart';

@injectable
@RestApi(parser: Parser.FlutterCompute)
abstract class BinanceRemoteDataSource {
  @factoryMethod
  factory BinanceRemoteDataSource(
    final Dio dio, {
    @Named('route') final String baseUrl,
  }) = _BinanceRemoteDataSource;

  @GET('/24hr')
  Future<List<BinanceDto>> getCurrencies();

  @GET('/price?symbol=BTCUSDT')
  Future<BitcoinDto?> getBitcoin();
}

BitcoinDto deserializeBitcoinDto(final Map<String, dynamic> json) =>
    BitcoinDto.fromJson(json);

BinanceDto deserializeBinanceDto(final Map<String, dynamic> json) =>
    BinanceDto.fromJson(json);

List<BinanceDto> deserializeBinanceDtoList(
  final List<Map<String, dynamic>> json,
) =>
    json.map((final e) => BinanceDto.fromJson(e)).toList();

Map<String, dynamic> serializeBinanceDto(final BinanceDto object) =>
    object.toJson();

List<Map<String, dynamic>> serializeBinanceDtoList(
  final List<BinanceDto> objects,
) =>
    objects.map((final e) => e.toJson()).toList();
