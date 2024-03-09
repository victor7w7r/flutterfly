import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/errors.dart';
import 'package:flutterfly/features/common/ui/services/services.dart';
import 'package:flutterfly/features/fluent/ui/providers/fluent.riverpod.dart';

final class ColorButton extends StatelessWidget {
  const ColorButton({
    required this.back,
    required this.border,
    required this.onClick,
    super.key,
  });

  final Color back;
  final Color border;
  final VoidCallback onClick;

  @override
  Widget build(final BuildContext context) => Button(
        style: ButtonStyle(
          elevation: ButtonState.all<double>(0),
          backgroundColor: ButtonState.all<Color>(back),
          shape: ButtonState.all<CircleBorder>(
            CircleBorder(side: BorderSide(width: 4, color: border)),
          ),
        ),
        onPressed: onClick,
        child: const Padding(padding: EdgeInsets.fromLTRB(25, 25, 25, 25)),
      );
}

final class HomeCardBrand extends ConsumerWidget {
  const HomeCardBrand({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final theme = ref.watch(fluentProvider$);

    return Card(
      backgroundColor: theme.themeColor[1],
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
      child: n.Column([
        'Made with love by'.n
          ..fontFamily = 'AminaReska'
          ..color = theme.themeColor[2]
          ..fontSize = context.mWidth > 960 ? 20 : 15,
        n.Image.asset('assets/${theme.isDark ? 'brandwhite' : 'brand'}.png')
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
          ..fontSize = context.mWidth > 960 ? 60 : 40,
      ]),
    );
  }
}

final class HomeCardCrypto extends ConsumerWidget {
  const HomeCardCrypto({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final theme = ref.watch(fluentProvider$);

    return Card(
      backgroundColor: theme.themeColor[1],
      borderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.fromLTRB(
        100,
        context.mWidth > 960 ? 75 : 5,
        100,
        context.mWidth > 960 ? 75 : 5,
      ),
      child: n.Column([
        const SizedBox(height: 45),
        Consumer(
          builder: (final _, final ref, final __) {
            final data = ref.watch(dataProvider$);
            return n.Text(
              data.isEmpty
                  ? 'Store state: Not yet.'
                  : 'Store state: Yes, you write. $data',
            )
              ..fontSize = 20
              ..color = theme.themeColor[2]
              ..n.center;
          },
        ),
        const SizedBox(height: 45),
        ...ref.watch(bitcoinProvider$).when(
              loading: () => const [ProgressRing(value: 35)],
              error: (final err, final _) => [
                const SizedBox(height: 120),
                (err as HttpNotSuccess).message.n..fontSize = 20,
              ],
              data: (final bit) => [
                'Symbol: ${bit.symbol}'.n
                  ..color = theme.themeColor[2]
                  ..fontSize = 20,
                'Price: ${bit.price}'.n
                  ..color = theme.themeColor[2]
                  ..fontSize = 20,
                const SizedBox(height: 45),
              ],
            ),
      ]),
    );
  }
}
