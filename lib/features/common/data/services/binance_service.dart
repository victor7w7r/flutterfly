import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/config/inject/inject.dart';
import 'package:flutterfly/features/common/domain/models/models.dart';
import 'package:flutterfly/features/common/domain/repository/binance_repository.dart';

final class BinanceService {

  final BinanceRepository _binanceRepository;

  BinanceService():
    _binanceRepository = inject.get<BinanceRepository>();

  Future<List<Binance>> getCurrencies() =>
    _binanceRepository
      .getCurrencies()
      .match((l) => throw l, (r) => r)
      .run();

  Future<Bitcoin> getBitcoin() =>
    _binanceRepository
      .getBitcoin()
      .match((l) => throw l, (r) => r)
      .run();

}

final binanceService = Provider((_) => BinanceService());