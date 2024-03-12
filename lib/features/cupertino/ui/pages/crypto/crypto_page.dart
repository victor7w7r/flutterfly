import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/config/inject.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';
import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto_widgets.dart';

final class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

final class _CryptoPageState extends State<CryptoPage> {
  final scrCtl = ScrollController();

  late QueryBinance _query;

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
          ? inject.get<BinanceService>().paginateBinance(_query)
          : null;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ViewModel<BinanceService>(
        builder: (final ctl) => QueryBinanceBuilder(
          'binance_fetch',
          ctl.fetchBinance,
          queryAccess: (final query) => _query = query,
          initial: const [],
          loading: () => n.Row(
            const [SizedBox(height: 120), CupertinoActivityIndicator()],
          )..mainCenter,
          error: (final _, final error) => n.Row([
            const SizedBox(height: 120),
            error.message.n..fontSize = 20,
          ])
            ..mainCenter
            ..crossCenter,
          success: (final query, final data) => CustomScrollView(
            controller: scrCtl,
            physics: const BouncingScrollPhysics(),
            slivers: [
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Crypto Data'),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: () async => ctl.refreshBinance(query),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 10.0,
                  children: data
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
        ),
      );
}
