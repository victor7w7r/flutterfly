import 'package:flutter/cupertino.dart';

import 'package:fl_query/fl_query.dart' show Query;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/core/utils/query.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';
import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto_widgets.dart';

final class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key, this.child, this.mockError = false});

  final Widget? child;
  final bool mockError;

  @override
  State<CryptoPage> createState() => CryptoPageState();
}

final class CryptoPageState extends State<CryptoPage> {
  @visibleForTesting
  // ignore: avoid_public_members_in_states
  final scrCtl = ScrollController();

  late Query<List<Binance>, FetchException> _query;

  @override
  void initState() {
    super.initState();
    scrCtl.addListener(_scrollListener);
  }

  void _scrollListener() =>
      scrCtl.position.pixels == scrCtl.position.maxScrollExtent
          ? GetIt.I<BinanceService>().paginateBinance(_query)
          : null;

  @override
  void dispose() {
    scrCtl.removeListener(_scrollListener);
    // ignore: cascade_invocations
    scrCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(
    final BuildContext context,
  ) =>
      widget.child ??
      ViewModel<BinanceService>(
        builder: (final ctl) => BaseQueryBuilder<List<Binance>, FetchException>(
          'binance_fetch',
          ctl.fetchBinance,
          loading: () => n.Row(
            const [SizedBox(height: 120), CupertinoActivityIndicator()],
          )..mainCenter,
          error: (final _, final error) => n.Row(
            [
              const SizedBox(height: 120),
              error == null
                  ? ('An error occurred'.n..fontSize = 20)
                  : (error.message.n..fontSize = 20),
            ],
          )
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
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 2,
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
          def: [Binance.detached()],
          queryAccess: (final query) => _query = query,
          mockError: widget.mockError,
        ),
      );
}
