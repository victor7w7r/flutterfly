import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/config/index.dart';
import 'package:flutterfly/modules/common/models/binance.dart';
import 'package:flutterfly/modules/common/models/bitcoin.dart';
import 'package:flutterfly/modules/common/services/binance_service.dart';
import 'package:flutterfly/utils/index.dart';

class BinanceNotifier extends AsyncNotifier<List<Binance>> {

  final allBin = <Binance>[];
  int position = 0;

  @override
  Future<List<Binance>> build() async {
    List<Binance> binList = [];
    isWeb
      ? binList = Binance.dummyGen()
      : binList = await locator.get<BinanceService>().getCurrencies();
    allBin.addAll(binList);
    position = 40;
    return binList.sublist(0, 40);
  }

  void paginate() {
    state = AsyncValue.data(allBin.sublist(0, position + 40));
    position += 40;
  }

}
final binanceProvider =
  AsyncNotifierProvider<BinanceNotifier, List<Binance>>(
    BinanceNotifier.new
  );

final bitcoinProvider = FutureProvider.autoDispose((_) => isWeb
  ? Future.value(Bitcoin.dummy())
  : locator.get<BinanceService>().getBitcoin()
);