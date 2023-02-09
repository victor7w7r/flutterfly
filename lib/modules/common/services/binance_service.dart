import 'package:injectable/injectable.dart' show injectable;

import 'package:flutterfly/modules/common/models/binance.dart';
import 'package:flutterfly/modules/common/models/bitcoin.dart';
import 'package:flutterfly/modules/common/repository/binance_repository.dart';

@injectable
class BinanceService {

  const BinanceService(this._binanceRepository);

  final BinanceRepository _binanceRepository;

  Future<List<Binance>> getCurrencies() => _binanceRepository
    .getCurrencies()
    .match((l) => throw l, (r) => r)
    .run();

  Future<Bitcoin> getBitcoin() => _binanceRepository
    .getBitcoin()
    .match((l) => throw l, (r) => r)
    .run();

}