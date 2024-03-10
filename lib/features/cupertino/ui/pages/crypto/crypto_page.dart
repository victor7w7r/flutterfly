import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/errors.dart';
import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto_widgets.dart';

final class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

final class _CryptoPageState extends State<CryptoPage> {
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

  void _scrollListener() =>
      scrCtl.position.pixels == scrCtl.position.maxScrollExtent
          ? ref.read(binanceProvider$.notifier).paginate()
          : null;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ref.watch(binanceProvider$).when(
            loading: () => n.Row(
              const [SizedBox(height: 120), CupertinoActivityIndicator()],
            )..mainCenter,
            error: (final err, final _) => n.Row([
              const SizedBox(height: 120),
              (err as HttpNotSuccess).message.n..fontSize = 20,
            ])
              ..mainCenter
              ..crossCenter,
            data: (final currs) => CustomScrollView(
              controller: scrCtl,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const CupertinoSliverNavigationBar(
                  largeTitle: Text('Crypto Data'),
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: () async => ref.refresh(binanceProvider$.future),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 10.0,
                    children: currs
                        .map(
                          (final bin) => CurrencyCard(
                            sym: bin.symbol,
                            per: bin.priceChangePercent,
                            pri: bin.bidPrice,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
}
