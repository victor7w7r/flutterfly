import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fl_query/fl_query.dart' show Query;
import 'package:fpdart/fpdart.dart' show identity;
import 'package:injectable/injectable.dart' show lazySingleton;

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/utils/utils.dart';
import 'package:flutterfly/features/common/business/entities/entities.dart';
import 'package:flutterfly/features/common/business/usecases/usecases.dart';

typedef QueryBinanceBuilder = BaseQueryBuilder<List<Binance>, FetchException>;
typedef QueryBinance = Query<List<Binance>, FetchException>;

typedef QueryBitcoinBuilder = BaseQueryBuilder<Bitcoin, FetchException>;
typedef QueryBitcoin = Query<Bitcoin, FetchException>;

@lazySingleton
final class BinanceService {
  BinanceService(this._getCurrenciesUseCase, this._getBitcoinUseCase);

  final GetCurrenciesUseCase _getCurrenciesUseCase;
  final GetBitcoinUseCase _getBitcoinUseCase;

  final _allBin = <Binance>[];
  var _position = 0;

  Future<List<Binance>> fetchBinance() async {
    final binList = <Binance>[];
    isWeb
        ? binList.addAll(Binance.dummyGen())
        : binList.addAll((await getCurrencies()).unlock);
    _allBin.addAll(binList);
    _position = 40;
    return binList.sublist(0, 40);
  }

  Future<IList<Binance>> getCurrencies() async =>
      (await _getCurrenciesUseCase())
          .fold((final l) => throw FetchException(l.message), identity);

  Future<Bitcoin?> getBitcoin() async => (await _getBitcoinUseCase())
      .fold((final l) => throw FetchException(l.message), identity);

  void refreshBinance(final QueryBinance query) => query
    // ignore: discarded_futures
    ..reset()
    // ignore: discarded_futures
    ..refresh();

  void paginateBinance(final QueryBinance query) {
    query.setData(_allBin.sublist(0, _position + 40));
    _position += 40;
  }
}
