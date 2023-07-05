import 'package:fpdart/fpdart.dart' show Task, TaskEither;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/modules/dio_module.dart';
import 'package:flutterfly/core/utils/errors.dart';
import 'package:flutterfly/features/common/models/models.dart';

part 'binance_repository.g.dart';

typedef TaskListBinance = TaskEither<HttpNotSuccess, List<Binance>>;
typedef TaskBitcoin = TaskEither<HttpNotSuccess, Bitcoin>;

final class BinanceRepository {

  final String _bitRoute;
  final String _currRoute;
  final DioModule _dio;

  const BinanceRepository(this._dio):
    _currRoute = '/24hr',
    _bitRoute = '/price?symbol=BTCUSDT';

  TaskListBinance getCurrencies() => TaskEither.tryCatch(
    Task(() => _dio.client.get(_currRoute))
      .map((res) =>
        Binance.fromJsonToList(res.data as List<dynamic>)
      ).run,
    HttpNotSuccess.throwError
  );

  TaskBitcoin getBitcoin() => TaskEither.tryCatch(
    Task(() => _dio.client.get(_bitRoute))
      .map((res) =>
        Bitcoin.fromJson(res.data as Map<String, dynamic>)
      ).run,
    HttpNotSuccess.throwError
  );
}

@riverpod
BinanceRepository binanceRepository(
  final BinanceRepositoryRef ref
) => BinanceRepository(ref.watch(dioModule$));