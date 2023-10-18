import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/models/models.dart';
import 'package:flutterfly/features/common/services/binance.service.dart';

part 'binance.riverpod.g.dart';

@riverpod
final class BinanceProvider extends _$BinanceProvider {
  final _allBin = <Binance>[];
  var _position = 0;

  @override
  Future<List<Binance>> build() async {
    final binList = <Binance>[];
    isWeb
        ? binList.addAll(Binance.dummyGen())
        : binList.addAll(await getCurrencies());
    _allBin.addAll(binList);
    _position = 40;
    return binList.sublist(0, 40);
  }

  Future<List<Binance>> getCurrencies() => ref
      .read(binanceService$)
      .getCurrencies()
      .match((final l) => throw l, (final r) => r)
      .run();

  Future<Bitcoin> getBitcoin() => ref
      .read(binanceService$)
      .getBitcoin()
      .match((final l) => throw l, (final r) => r)
      .run();

  void paginate() {
    state = AsyncValue.data(_allBin.sublist(0, _position + 40));
    _position += 40;
  }
}

@riverpod
Future<Bitcoin> bitcoinProvider(final BitcoinProviderRef ref) => isWeb
    ? Future.value(Bitcoin.dummy())
    : ref.read(binanceProvider$.notifier).getBitcoin();
