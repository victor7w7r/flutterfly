import 'package:fpdart/fpdart.dart' show Task, TaskEither;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/modules/dio.module.dart';
import 'package:flutterfly/core/utils/errors.dart';
import 'package:flutterfly/features/common/models/models.dart';

part 'binance.service.g.dart';

typedef TaskListBinance = TaskEither<HttpNotSuccess, List<Binance>>;
typedef TaskBitcoin = TaskEither<HttpNotSuccess, Bitcoin>;

final class BinanceService {

  const BinanceService(this._dio);

  final DioModule _dio;

  TaskListBinance getCurrencies() => TaskEither.tryCatch(
    Task(() async => _dio.client.get<List<dynamic>>(_currRoute))
      .map((final res) =>
        Binance.fromJsonToList(res.data ?? [])
      ).run,
    HttpNotSuccess.throwError
  );

  TaskBitcoin getBitcoin() => TaskEither.tryCatch(
    Task(() async => _dio.client.get<Map<String, dynamic>>(_bitRoute))
      .map((final res) =>
        Bitcoin.fromJson(res.data ?? {})
      ).run,
    HttpNotSuccess.throwError
  );

  String get _currRoute => '/24hr';
  String get _bitRoute => '/price?symbol=BTCUSDT';

}

@riverpod
BinanceService binanceService(
  final BinanceServiceRef ref
) => BinanceService(ref.watch(dioModule$));
