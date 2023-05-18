import 'package:fpdart/fpdart.dart' show Task, TaskEither;
import 'package:injectable/injectable.dart' show injectable;

import 'package:flutterfly/core/modules/dio_module.dart';
import 'package:flutterfly/core/utils/errors.dart';
import 'package:flutterfly/features/common/domain/models/models.dart';

typedef TaskListBinance = TaskEither<HttpNotSuccess, List<Binance>>;
typedef TaskBitcoin = TaskEither<HttpNotSuccess, Bitcoin>;

@injectable
class BinanceRepository {

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