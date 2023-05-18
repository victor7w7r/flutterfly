import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show AsyncValueX;
import 'package:nester/nester.dart' show Nester;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/config/extensions/extensions.dart';
import 'package:flutterfly/core/utils/index.dart';
import 'package:flutterfly/features/common/data/providers/providers.dart';
import 'package:flutterfly/features/common/presentation/widgets/consumer.dart';
import 'package:flutterfly/features/material/data/providers/material_provider.dart';

final class TopContent extends StatelessWidget {

  final double height;
  final Orientation pOrientation;

  const TopContent({
    super.key,
    required this.height,
    required this.pOrientation
  });

  @override
  Widget build(context) => n.Column([
    SizedBox(
      height: pOrientation == Orientation.portrait
        ? 30 : height / 3.5
    ),
    const DynamicChip(isHome: false),
    const SizedBox(height: 15),
    'Happy Hacking!, Dart... Dart...'.n
      ..fontSize = (height > 960 ) ? 30 : 20,
    const SizedBox(height: 10),
    AppConsumer((ref) {
      final data = ref.watch(dataProvider);
      return n.Text(data.isEmpty
        ? 'Store state: Not yet.'
        : 'Store state: Yes, you write. $data'
      )
        ..fontSize = data.isEmpty ? (
          (height > 960) ? 25 : 15
        ) : 20
        ..n.center;
    }),
    const SizedBox(height: 25),
    'Made with love by '.n
      ..freezed
      ..fontSize = 14
      ..n.center,
    const SizedBox(height: 20),
    const DynamicChip(isHome: true)
  ]);
}

final class DynamicChip extends StatelessWidget {

  final bool isHome;

  const DynamicChip({
    super.key,
    required this.isHome
  });

  @override
  Widget build(context) {

    final dark = context.watch(materialProvider);

    return Container(
      width: isHome ? 300 : 270,
      height: isHome ? 60 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: dark ? Border.all(
          width: 2,
          color: TWColors.gray.shade100
        ) : Border.all(
          width: 2,
          color: TWColors.gray.shade900
        )
      ),
      child: n.Row(isHome ? [
        const SizedBox(width: 38),
        n.Image.asset(
          'assets/${ dark ? 'brandwhite' : 'brand'}.png'
        )
          ..width = 220.0
          ..height = 70.0
        ] : [
        n.Image.asset('assets/flutter-logo.png')
          ..width = 77.0
          ..height = 35.0,
        'Flutter Template'.n
          ..freezed
          ..fontSize = 20
      ])
    );
  }
}

final class BottomContent extends StatefulWidget {

  final double height;
  final Orientation pOrientation;

  const BottomContent({
    super.key,
    required this.height,
    required this.pOrientation
  });

  @override
  State<BottomContent> createState() =>
    _BottomContentState();

}

final class _BottomContentState
  extends State<BottomContent> {

  final scrCtl = ScrollController();

  void _scrollListener () =>
    scrCtl.position.pixels == scrCtl.position.maxScrollExtent
      ? context.read(binanceProvider.notifier)
        .paginate()
      : null;

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

  Future<void> refresh() async {
    context.refresh(binanceProvider);
    await context.read(binanceProvider.future);
  }

  @override
  Widget build(context) => n.Column([
    const SizedBox(height: 35),
    'Cryptocurrency data'.n
      ..fontSize = (widget.height > 960) ? 35 : 30
      ..n.center,
    const SizedBox(height: 25),
    context.watch(binanceProvider).when(
      loading: () => n.Row(const [
        SizedBox(height: 120),
        CircularProgressIndicator()
      ])
        ..mainCenter,
      error: (err, _) => n.Row([
        const SizedBox(height: 120),
        (err as HttpNotSuccess).message.n
          ..fontSize = 20
      ])
        ..mainCenter
        ..crossCenter,
      data: (currs) => Nester.list([
        (next) => Expanded(child: next),
        (next) => RefreshIndicator(
          onRefresh: refresh,
          child: next
        ), (_) => n.GridView.count(crossAxisCount: 2)
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

final class CurrencyCard extends StatelessWidget {

  final Orientation orientation;
  final String per;
  final String pri;
  final String sym;

  const CurrencyCard({
    super.key,
    required this.orientation,
    required this.per,
    required this.pri,
    required this.sym
  });

  @override
  Widget build(context) => Container(
    margin: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10
    ), padding: const EdgeInsets.symmetric(
      horizontal: 10
    ), decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      border: context.watch(materialProvider)
        ? Border.all(
          width: 2,
          color: TWColors.gray.shade100
        ) : Border.all(
          width: 2,
          color: TWColors.gray.shade900
        ),
      image: DecorationImage(
        alignment: const Alignment(1.3, 0),
        image: const AssetImage('assets/binance.png'),
        scale: context.mWidth > 520 ? 12 : 20,
        fit: BoxFit.none
      )
    ),
    child: n.Column([
      orientation == Orientation.portrait
      ? switch(context.mWidth) {
        > 720 => const SizedBox(height: 45),
        > 520 => const SizedBox(height: 20),
        > 320 => const SizedBox(height: 10),
        _ => Container()
      } : switch(context.mWidth) {
        > 1920 => const SizedBox(height: 65),
        > 1280 => const SizedBox(height: 30),
        > 1024 => const SizedBox(height: 15),
        > 960 => const SizedBox(height: 10),
        > 866 => const SizedBox(height: 5),
        _ => Container()
      },
      sym.n
        ..fontSize = (
          context.mWidth > 520
        ) ? 20 : 15
        ..fontWeight = FontWeight.bold,
      '$per%'.n
        ..fontSize = (
          context.mWidth > 520
        ) ? 12 : 10
        ..fontWeight = FontWeight.bold,
      pri.n
        ..fontSize = (
          context.mWidth > 520
        ) ? 12 : 10
        ..fontWeight = FontWeight.bold
    ])
      ..crossStart
  );
}