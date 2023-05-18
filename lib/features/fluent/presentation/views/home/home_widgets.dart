import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show AsyncValueX, Consumer;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/config/extensions/extensions.dart';
import 'package:flutterfly/core/utils/index.dart';
import 'package:flutterfly/features/common/data/providers/providers.dart';
import 'package:flutterfly/features/fluent/data/providers/fluent_provider.dart';

final class ColorButton extends StatelessWidget {

  final Color back;
  final Color border;
  final VoidCallback onClick;

  const ColorButton({
    super.key,
    required this.back,
    required this.border,
    required this.onClick
  });

  @override
  Widget build(context) => Button(
    style: ButtonStyle(
      elevation: ButtonState.all<double>(0),
      backgroundColor: ButtonState.all<Color>(back),
      shape: ButtonState.all<CircleBorder> (
        CircleBorder(
          side: BorderSide(
            width: 4,
            color: border,
            style: BorderStyle.solid
          )
        )
      )
    ),
    onPressed: onClick,
    child: const Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 25)
    )
  );
}

final class HomeCardBrand extends StatelessWidget {

  const HomeCardBrand({super.key});

  @override
  Widget build(context) {

    final theme = context.watch(fluentProvider);

    return Card(
      backgroundColor: theme.themeColor[1],
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
      child: n.Column([
        'Made with love by'.n
          ..fontFamily = 'AminaReska'
          ..color = theme.themeColor[2]
          ..fontSize = context.mWidth > 960 ? 20 : 15,
        n.Image.asset(
          'assets/${theme.isDark ? 'brandwhite' : 'brand'}.png'
        )
          ..width = context.mWidth > 960 ? 500.0 : 300.0
          ..height = 100.0,
        'Happy Hacking!, Dart... Dart...'.n
          ..color = theme.themeColor[2]
          ..fontSize = context.mWidth > 960 ? 20 : 15,
        const SizedBox(height: 15),
        'This UI is powered by'.n
          ..color = theme.themeColor[2]
          ..fontSize = context.mWidth > 960 ? 20 : 15,
        const SizedBox(height: 30),
        'Fluent UI'.n
          ..color = theme.themeColor[2]
          ..fontSize = context.mWidth > 960 ? 60 : 40
      ])
    );
  }
}

final class HomeCardCrypto extends StatelessWidget {

  const HomeCardCrypto({ super.key });

  @override
  Widget build(context) {

    final theme = context.watch(fluentProvider);

    return Card(
      backgroundColor: theme.themeColor[1],
      borderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.fromLTRB(
        100, context.mWidth > 960 ? 75 : 5,
        100, context.mWidth > 960 ? 75 : 5
      ),
      child: n.Column([
        const SizedBox(height: 45),
        Consumer(builder: (_, ref, __) {
          final data = ref.watch(dataProvider);
          return n.Text(data.isEmpty
            ? 'Store state: Not yet.'
            : 'Store state: Yes, you write. $data'
          )
            ..fontSize = 20
            ..color = theme.themeColor[2]
            ..n.center;
        }),
        const SizedBox(height: 45),
        ...(context.watch(bitcoinProvider).when(
          loading: () => const [ProgressRing(value: 35)],
          error: (err, _) => [
            const SizedBox(height: 120),
            (err as HttpNotSuccess).message.n
              ..fontSize = 20
          ],
          data: (bit) => [
            'Symbol: ${bit.symbol}'.n
              ..color = theme.themeColor[2]
              ..fontSize = 20,
            'Price: ${bit.price}'.n
              ..color = theme.themeColor[2]
              ..fontSize = 20,
            const SizedBox(height: 45),
          ]
        ))
      ])
    );
  }
}