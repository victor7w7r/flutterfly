import 'package:flutter/material.dart';

import 'package:fl_query/fl_query.dart' show Query;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/core/utils/query.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/ui/services/services.dart';
import 'package:flutterfly/features/common/ui/widgets/nest.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class TopContent extends StatelessWidget {
  const TopContent({
    required this.height,
    required this.pOrientation,
    this.child,
    super.key,
  });

  final Widget? child;
  final double height;
  final Orientation pOrientation;

  @override
  Widget build(final BuildContext context) =>
      child ??
      n.Column([
        SizedBox(
          height: pOrientation == Orientation.portrait ? 30 : height / 3.5,
        ),
        const DynamicChip(isHome: false),
        const SizedBox(height: 15),
        'Happy Hacking!, Dart... Dart...'.n
          ..fontSize = (height > 960) ? 30 : 20,
        const SizedBox(height: 10),
        ListenViewModel<DataService>(
          builder: (final ctl) => n.Text(
            ctl.state.isEmpty
                ? 'Store state: Not yet.'
                : 'Store state: Yes, you write. ${ctl.state}',
          )
            ..fontSize = ctl.state.isEmpty ? ((height > 960) ? 25 : 15) : 20
            ..n.center,
        ),
        const SizedBox(height: 10),
        'Made with love by '.n
          ..freezed
          ..fontSize = 14
          ..n.center,
        const SizedBox(height: 15),
        const DynamicChip(isHome: true),
      ]);
}

final class DynamicChip extends StatelessWidget {
  const DynamicChip({required this.isHome, super.key});

  final bool isHome;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<MaterialService>(
        builder: (final ctl) => Container(
          decoration: BoxDecoration(
            border: ctl.isDark
                ? const Border.fromBorderSide(
                    BorderSide(color: Colors.white, width: 2),
                  )
                : const Border.fromBorderSide(BorderSide(width: 2)),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          width: isHome ? 300 : 270,
          height: 50,
          child: n.Row(
            isHome
                ? [
                    const SizedBox(width: 38),
                    n.Image.asset(
                        'assets/${ctl.isDark ? 'brandwhite' : 'brand'}.png')
                      ..width = 220.0
                      ..height = 70.0,
                  ]
                : [
                    n.Image.asset('assets/flutter-logo.png')
                      ..width = 77.0
                      ..height = 35.0,
                    'Flutter Template'.n
                      ..freezed
                      ..expanded
                      ..fontSize = 20,
                  ],
          ),
        ),
      );
}

final class BottomContent extends StatefulWidget {
  const BottomContent({
    required this.height,
    required this.pOrientation,
    this.mockError = false,
    this.child,
    super.key,
  });

  final Widget? child;
  final double height;
  final bool mockError;
  final Orientation pOrientation;

  @override
  State<BottomContent> createState() => BottomContentState();
}

final class BottomContentState extends State<BottomContent> {
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
  Widget build(final BuildContext context) =>
      widget.child ??
      n.Column([
        'Cryptocurrency data'.n
          ..fontSize = (widget.height > 960) ? 35 : 20
          ..n.center,
        const SizedBox(height: 15),
        ViewModel<BinanceService>(
          builder: (final ctl) =>
              BaseQueryBuilder<List<Binance>, FetchException>(
            'binance_fetch',
            ctl.fetchBinance,
            loading: () => n.Row(
              const [
                SizedBox(height: 120),
                CircularProgressIndicator(),
              ],
            )..mainCenter,
            error: (final _, final error) => n.Row([
              const SizedBox(height: 120),
              error == null
                  ? ('An error occurred'.n..fontSize = 20)
                  : (error.message.n..fontSize = 20),
            ])
              ..mainCenter
              ..crossCenter,
            success: (final query, final data) => Nest([
              (final next) => Expanded(child: next),
              (final next) => RefreshIndicator(
                    onRefresh: () async => ctl.refreshBinance(query),
                    child: next,
                  ),
              (final _) => n.GridView.count(crossAxisCount: 2)
                ..childAspectRatio = 2
                ..px = 40
                ..physics = const AlwaysScrollableScrollPhysics()
                ..mainAxisSpacing = 10.0
                ..scrollDirection = Axis.vertical
                ..controller = scrCtl
                ..children = data
                    .map(
                      (final bin) => CurrencyCard(
                        orientation: widget.pOrientation,
                        per: bin.priceChangePercent,
                        pri: bin.bidPrice,
                        sym: bin.symbol,
                      ),
                    )
                    .toList(),
            ]),
            def: [Binance.detached()],
            queryAccess: (final query) => _query = query,
            mockError: widget.mockError,
          ),
        ),
      ]);
}

final class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    required this.orientation,
    required this.per,
    required this.pri,
    required this.sym,
    super.key,
  });

  final Orientation orientation;
  final String per;
  final String pri;
  final String sym;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<MaterialService>(
        builder: (final ctl) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/binance.png'),
              fit: BoxFit.none,
              alignment: const Alignment(1.3, 0),
              scale: context.mWidth > 520 ? 12 : 20,
            ),
            border: ctl.isDark
                ? const Border.fromBorderSide(
                    BorderSide(color: Colors.white, width: 2),
                  )
                : const Border.fromBorderSide(BorderSide(width: 2)),
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          margin: const EdgeInsets.all(10),
          child: n.Column([
            orientation == Orientation.portrait
                ? switch (context.mWidth) {
                    > 720 => const SizedBox(height: 45),
                    > 520 => const SizedBox(height: 20),
                    > 320 => const SizedBox(height: 10),
                    _ => Container()
                  }
                : switch (context.mWidth) {
                    > 1920 => const SizedBox(height: 65),
                    > 1280 => const SizedBox(height: 30),
                    > 1024 => const SizedBox(height: 15),
                    > 960 => const SizedBox(height: 10),
                    > 866 => const SizedBox(height: 5),
                    _ => Container()
                  },
            sym.n
              ..fontSize = (context.mWidth > 520) ? 20 : 12
              ..fontWeight = FontWeight.bold,
            '$per%'.n
              ..fontSize = (context.mWidth > 520) ? 12 : 8
              ..fontWeight = FontWeight.bold,
            pri.n
              ..fontSize = (context.mWidth > 520) ? 12 : 8
              ..fontWeight = FontWeight.bold,
          ])
            ..crossStart,
        ),
      );
}
