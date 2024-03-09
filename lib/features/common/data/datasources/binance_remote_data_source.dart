import 'package:dio/dio.dart' show Dio;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flutterfly/features/common/data/dto/binance_dto.dart';
import 'package:flutterfly/features/common/data/dto/bitcoin_dto.dart';

part '../../../../generated/features/common/data/datasources/binance_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class BinanceRemoteDataSource {
  @factoryMethod
  factory BinanceRemoteDataSource(
    final Dio dio, {
    @Named('route') final String baseUrl,
  }) = _BinanceRemoteDataSource;

  @GET('/price?symbol=BTCUSDT')
  Future<List<BinanceDto>> getCurrencies();

  @GET('/24hr')
  Future<BitcoinDto?> getBitcoin();
}
