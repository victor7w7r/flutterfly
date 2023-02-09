import 'package:flutter/material.dart';

import 'package:conditioned/conditioned.dart' show Case, Conditioned;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nester/nester.dart' show Nester;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/modules/common/providers/binance_provider.dart';
import 'package:flutterfly/modules/common/providers/data_provider.dart';
import 'package:flutterfly/modules/material/providers/material_provider.dart';
import 'package:flutterfly/utils/index.dart';

class TopContent extends StatelessWidget {

  const TopContent({
    super.key,
    required this.pSize,
    required this.pOrientation
  });

  final Size pSize;
  final Orientation pOrientation;

  @override
  Widget build(context) => n.Column([
    SizedBox(
      height: pOrientation == Orientation.portrait? 30 : pSize.height / 3.5
    ),
    const DynamicChip(isHome: false),
    const SizedBox(height: 15),
    "Happy Hacking!, Dart... Dart...".n
      ..fontSize = (pSize.height > 960 ) ? 30 : 20,
    const SizedBox(height: 10),
    Consumer(builder: (_, ref, __) {
      final data = ref.watch(dataProvider);
      return n.Text(data.isEmpty
        ? "Store state: Not yet."
        : "Store state: Yes, you write. $data"
      )
        ..fontSize = data.isEmpty ? ((pSize.height > 960 ) ? 25 : 15) : 20
        ..n.center;
    }),
    const SizedBox(height: 25),
    "Made with love by ".n
      ..freezed
      ..fontSize = 14
      ..n.center,
    const SizedBox(height: 20),
    const DynamicChip(isHome: true)
  ]);
}

class DynamicChip extends StatelessWidget {

  const DynamicChip({ super.key, required this.isHome });

  final bool isHome;

  @override
  Widget build(context) {

    final dark = context.watch(materialProvider);

    return Container(
      width: isHome ? 300 : 270,
      height: isHome ? 60 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: dark
          ? Border.all(width: 2, color: TWColors.gray.shade100)
          : Border.all(width: 2, color: TWColors.gray.shade900)
      ),
      child: n.Row(isHome ? [
        const SizedBox(width: 38),
        n.Image.asset(dark ? 'assets/brandwhite.png': 'assets/brand.png')
          ..width = 220.0
          ..height = 70.0
        ] : [
        n.Image.asset('assets/flutter-logo.png')
          ..width = 77.0
          ..height = 35.0,
        "Flutter Template".n
          ..freezed
          ..fontSize = 20
      ])
    );
  }
}

class BottomContent extends StatefulWidget {

  @override
  State<BottomContent> createState() => _BottomContentState();

  const BottomContent({
    super.key,
    required this.pSize,
    required this.pOrientation
  });

  final Size pSize;
  final Orientation pOrientation;

}

class _BottomContentState extends State<BottomContent> {

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
  Widget build(context) => n.Column([
    const SizedBox(height: 35),
    "Cryptocurrency data".n
      ..fontSize = (widget.pSize.height > 960) ? 35 : 30
      ..n.center,
    const SizedBox(height: 25),
    context.watch(binanceProvider).when(
      loading: () => n.Row(const [
        SizedBox(height: 120),
        CircularProgressIndicator()
      ])
        ..mainAxisAlignment = MainAxisAlignment.center,
      error: (err, _) => n.Row([
        const SizedBox(height: 120),
        (err as HttpNotSuccess).message.n
          ..fontSize = 20
      ])
        ..mainAxisAlignment = MainAxisAlignment.center
        ..crossAxisAlignment = CrossAxisAlignment.center,
      data: (currs) => Nester.list([
        (next) => Expanded(child: next),
        (next) => RefreshIndicator(onRefresh: refresh, child: next),
        (_) => n.GridView.count(crossAxisCount: 2)
          ..childAspectRatio = 2
          ..px = 40
          ..physics = const AlwaysScrollableScrollPhysics()
          ..mainAxisSpacing = 10.0
          ..scrollDirection = Axis.vertical
          ..controller = scrCtl
          ..children = currs.map((bin) => CurrencyCard(
            sym: bin.symbol,
            per: bin.priceChangePercent,
            pri: bin.bidPrice,
            orientation: widget.pOrientation
          )).toList()
      ])
    )
  ]);
}

class CurrencyCard extends StatelessWidget {

  const CurrencyCard({
    super.key,
    required this.sym,
    required this.per,
    required this.pri,
    required this.orientation
  });

  final String sym;
  final String per;
  final String pri;
  final Orientation orientation;

  @override
  Widget build(context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      border: context.watch(materialProvider)
        ? Border.all(width: 2, color: TWColors.gray.shade100)
        : Border.all(width: 2, color: TWColors.gray.shade900),
      image: DecorationImage(
        alignment: const Alignment(1.3, 0),
        image: const AssetImage('assets/binance.png'),
        scale: context.mediaQuerySize.width > 520 ? 12 : 20,
        fit: BoxFit.none
      )
    ),
    child: n.Column([
      orientation == Orientation.portrait ? Conditioned(
      cases: [
        Case(context.mediaQuerySize.width > 720, builder: () => const SizedBox(height: 45)),
        Case(context.mediaQuerySize.width > 520, builder: () => const SizedBox(height: 20)),
        Case(context.mediaQuerySize.width > 320, builder: () => const SizedBox(height: 10)),
      ],
      defaultBuilder: Container.new
    ) : Conditioned(
      cases: [
        Case(context.mediaQuerySize.width > 1920, builder: () => const SizedBox(height: 65)),
        Case(context.mediaQuerySize.width > 1280, builder: () => const SizedBox(height: 30)),
        Case(context.mediaQuerySize.width > 1024, builder: () => const SizedBox(height: 15)),
        Case(context.mediaQuerySize.width > 960, builder: () => const SizedBox(height: 10)),
        Case(context.mediaQuerySize.width > 866, builder: () => const SizedBox(height: 5)),
      ],
      defaultBuilder: Container.new
    ),
      sym.n
        ..fontSize = (context.mediaQuerySize.width > 520) ? 20 : 15
        ..fontWeight = FontWeight.bold,
      '$per%'.n
        ..fontSize = (context.mediaQuerySize.width > 520) ? 12 : 10
        ..fontWeight = FontWeight.bold,
      pri.n
        ..fontSize = (context.mediaQuerySize.width > 520) ? 12 : 10
        ..fontWeight = FontWeight.bold
    ])
      ..crossAxisAlignment = CrossAxisAlignment.start
  );
}