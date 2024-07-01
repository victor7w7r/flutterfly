import 'package:flutter/cupertino.dart';

import 'package:fl_query/fl_query.dart' show Query;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/di/inject.dart';
import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/core/utils/query.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';
import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto_widgets.dart';

final class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key, this.child});

  final Widget? child;

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

final class _CryptoPageState extends State<CryptoPage> {
  final _scrCtl = ScrollController();

  late Query<List<Binance>, FetchException> _query;

  @override
  void initState() {
    super.initState();
    _scrCtl.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrCtl.removeListener(_scrollListener);
    // ignore: cascade_invocations
    _scrCtl.dispose();
    super.dispose();
  }

  void _scrollListener() =>
      _scrCtl.position.pixels == _scrCtl.position.maxScrollExtent
          ? inject.get<BinanceService>().paginateBinance(_query)
          : null;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      widget.child ??
      ViewModel<BinanceService>(
        builder: (final ctl) => BaseQueryBuilder<List<Binance>, FetchException>(
          'binance_fetch',
          ctl.fetchBinance,
          queryAccess: (final query) => _query = query,
          def: [Binance.detached()],
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
            controller: _scrCtl,
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
