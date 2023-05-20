import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/core/utils/index.dart';
import 'package:flutterfly/features/common/data/services/binance_service.dart';
import 'package:flutterfly/features/common/domain/models/models.dart';

final class BinanceNotifier
  extends AsyncNotifier<List<Binance>> {

  final allBin = <Binance>[];
  var position = 0;

  @override
  Future<List<Binance>> build() async {
    final binList = <Binance>[];
    isWeb
      ? binList.addAll(Binance.dummyGen())
      : binList.addAll(
        await ref.read(binanceService).getCurrencies()
      );
    allBin.addAll(binList);
    position = 40;
    return binList.sublist(0, 40);
  }

  void paginate() {
    state = AsyncValue.data(
      allBin.sublist(0, position + 40)
    );
    position += 40;
  }

}
final binanceProvider =
  AsyncNotifierProvider<BinanceNotifier, List<Binance>>(
    BinanceNotifier.new
  );

final bitcoinProvider = FutureProvider
  .autoDispose((ref) => isWeb
    ? Future.value(Bitcoin.dummy())
    : ref.watch(binanceService).getBitcoin()
  );