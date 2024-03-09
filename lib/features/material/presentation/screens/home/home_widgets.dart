import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/errors.dart';
import 'package:flutterfly/features/common/ui/widgets/consumer.dart';
import 'package:flutterfly/features/common/ui/widgets/nest.dart';
import 'package:flutterfly/features/common/ui/services/providers.dart';
import 'package:flutterfly/features/material/providers/material.riverpod.dart';

final class TopContent extends StatelessWidget {
  const TopContent({
    required this.height,
    required this.pOrientation,
    super.key,
  });

  final double height;
  final Orientation pOrientation;

  @override
  Widget build(final BuildContext context) => n.Column([
        SizedBox(
          height: pOrientation == Orientation.portrait ? 30 : height / 3.5,
        ),
        const DynamicChip(isHome: false),
        const SizedBox(height: 15),
        'Happy Hacking!, Dart... Dart...'.n
          ..fontSize = (height > 960) ? 30 : 20,
        const SizedBox(height: 10),
        AppConsumer((final ref) {
          final data = ref.watch(dataProvider$);
          return n.Text(
            data.isEmpty
                ? 'Store state: Not yet.'
                : 'Store state: Yes, you write. $data',
          )
            ..fontSize = data.isEmpty ? ((height > 960) ? 25 : 15) : 20
            ..n.center;
        }),
        const SizedBox(height: 25),
        'Made with love by '.n
          ..freezed
          ..fontSize = 14
          ..n.center,
        const SizedBox(height: 20),
        const DynamicChip(isHome: true),
      ]);
}

final class DynamicChip extends ConsumerWidget {
  const DynamicChip({required this.isHome, super.key});

  final bool isHome;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final dark = ref.watch(materialProvider$);

    return Container(
      width: isHome ? 300 : 270,
      height: isHome ? 60 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: dark
            ? Border.all(width: 2, color: Colors.white)
            : Border.all(width: 2),
      ),
      child: n.Row(
        isHome
            ? [
                const SizedBox(width: 38),
                n.Image.asset('assets/${dark ? 'brandwhite' : 'brand'}.png')
                  ..width = 220.0
                  ..height = 70.0,
              ]
            : [
                n.Image.asset('assets/flutter-logo.png')
                  ..width = 77.0
                  ..height = 35.0,
                'Flutter Template'.n
                  ..freezed
                  ..fontSize = 20,
              ],
      ),
    );
  }
}

final class BottomContent extends ConsumerStatefulWidget {
  const BottomContent({
    required this.height,
    required this.pOrientation,
    super.key,
  });

  final double height;
  final Orientation pOrientation;

  @override
  ConsumerState<BottomContent> createState() => _BottomContentState();
}

final class _BottomContentState extends ConsumerState<BottomContent> {
  final scrCtl = ScrollController();

  void _scrollListener() =>
      scrCtl.position.pixels == scrCtl.position.maxScrollExtent
          ? ref.read(binanceProvider$.notifier).paginate()
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

  @override
  Widget build(final BuildContext context) => n.Column([
        const SizedBox(height: 35),
        'Cryptocurrency data'.n
          ..fontSize = (widget.height > 960) ? 35 : 30
          ..n.center,
        const SizedBox(height: 25),
        ref.watch(binanceProvider$).when(
              loading: () => n.Row(
                const [SizedBox(height: 120), CircularProgressIndicator()],
              )..mainCenter,
              error: (final err, final _) => n.Row([
                const SizedBox(height: 120),
                (err as HttpNotSuccess).message.n..fontSize = 20,
              ])
                ..mainCenter
                ..crossCenter,
              data: (final currs) => Nest([
                (final next) => Expanded(child: next),
                (final next) => RefreshIndicator(
                      onRefresh: () async =>
                          ref.refresh(binanceProvider$.future),
                      child: next,
                    ),
                (final _) => n.GridView.count(crossAxisCount: 2)
                  ..childAspectRatio = 2
                  ..px = 40
                  ..physics = const AlwaysScrollableScrollPhysics()
                  ..mainAxisSpacing = 10.0
                  ..scrollDirection = Axis.vertical
                  ..controller = scrCtl
                  ..children = currs
                      .map(
                        (final bin) => CurrencyCard(
                          sym: bin.symbol,
                          per: bin.priceChangePercent,
                          pri: bin.bidPrice,
                          orientation: widget.pOrientation,
                        ),
                      )
                      .toList(),
              ]),
            ),
      ]);
}

final class CurrencyCard extends ConsumerWidget {
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
  Widget build(final BuildContext context, final WidgetRef ref) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: ref.watch(materialProvider$)
              ? Border.all(width: 2, color: Colors.white)
              : Border.all(width: 2),
          image: DecorationImage(
            alignment: const Alignment(1.3, 0),
            image: const AssetImage('assets/binance.png'),
            scale: context.mWidth > 520 ? 12 : 20,
            fit: BoxFit.none,
          ),
        ),
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
            ..fontSize = (context.mWidth > 520) ? 20 : 15
            ..fontWeight = FontWeight.bold,
          '$per%'.n
            ..fontSize = (context.mWidth > 520) ? 12 : 10
            ..fontWeight = FontWeight.bold,
          pri.n
            ..fontSize = (context.mWidth > 520) ? 12 : 10
            ..fontWeight = FontWeight.bold,
        ])
          ..crossStart,
      );
}
