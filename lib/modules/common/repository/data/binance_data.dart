import 'package:dio/dio.dart' show Dio, DioError;
import 'package:fpdart/fpdart.dart' show Task, TaskEither;
import 'package:injectable/injectable.dart' show Injectable;

import 'package:flutterfly/modules/common/models/binance.dart';
import 'package:flutterfly/modules/common/models/bitcoin.dart';
import 'package:flutterfly/modules/common/repository/binance_repository.dart';
import 'package:flutterfly/utils/errors.dart';

@Injectable(as: BinanceRepository)
class BinanceData implements BinanceRepository {

  @override
  getCurrencies() => TaskEither.tryCatch(
    Task(() => Dio().get('http://api2.binance.com/api/v3/ticker/24hr'))
      .map((res) => Binance.fromJsonToList(res.data as List<dynamic>)).run,
    (e, _) => HttpNotSuccess.dioThrow(e as DioError)
  );

  @override
  getBitcoin() => TaskEither.tryCatch(
    Task(() => Dio().get('https://api2.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
      .map((res) => Bitcoin.fromJson(res.data as Map<String, dynamic>)).run,
    (e, _) => HttpNotSuccess.dioThrow(e as DioError)
  );
}