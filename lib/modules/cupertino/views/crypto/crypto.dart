import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show AsyncValueX;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/modules/common/providers/binance_provider.dart';
import 'package:flutterfly/modules/cupertino/views/crypto/crypto_widgets.dart';
import 'package:flutterfly/utils/errors.dart';

class Crypto extends StatefulWidget {

  const Crypto({super.key});

  @override
  State<Crypto> createState() => _CryptoState();
}

class _CryptoState extends State<Crypto> {

  final scrCtl = ScrollController();

  @override
  void initState() {
    super.initState();
    scrCtl.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrCtl.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener () =>
    scrCtl.position.pixels == scrCtl.position.maxScrollExtent
      ? context.read(binanceProvider.notifier).paginate()
      : null;

  Future<void> refresh() async {
    context.refresh(binanceProvider);
    await context.read(binanceProvider.future);
  }

  @override
  Widget build(context) => context.watch(binanceProvider).when(
    loading: () => n.Row(const [
      SizedBox(height: 120),
      CupertinoActivityIndicator()
    ])
      ..mainAxisAlignment = MainAxisAlignment.center,
    error: (err, _) => n.Row([
      const SizedBox(height: 120),
      (err as HttpNotSuccess).message.n
        ..fontSize = 20
    ])
      ..mainAxisAlignment = MainAxisAlignment.center
      ..crossAxisAlignment = CrossAxisAlignment.center,
    data: (currs) => CustomScrollView(
      scrollDirection: Axis.vertical,
      controller: scrCtl,
      physics: const BouncingScrollPhysics(),
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Crypto Data')
        ),
        CupertinoSliverRefreshControl(onRefresh: refresh),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            childAspectRatio: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 10.0,
            children: currs.map((bin) => CurrencyCard(
              sym: bin.symbol,
              per: bin.priceChangePercent,
              pri: bin.bidPrice
            )).toList()
          )
        )
      ]
    )
  );
}