import 'package:fluent_ui/fluent_ui.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/utils.dart';
import 'package:flutterfly/features/common/business/entities/bitcoin.dart';
import 'package:flutterfly/features/common/ui/services/services.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';

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
        child: const Padding(padding: EdgeInsets.all(25)),
      );
}

final class HomeCardBrand extends StatelessWidget {
  const HomeCardBrand({super.key});

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<FluentService>(
        builder: (final ctl) => Card(
          backgroundColor: ctl.state().themeColor[1],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: n.Column([
            'Made with love by'.n
              ..fontFamily = 'AminaReska'
              ..color = ctl.state().themeColor[2]
              ..fontSize = context.mWidth > 960 ? 20 : 15,
            n.Image.asset(
              'assets/${ctl.state().isDark ? 'brandwhite' : 'brand'}.png',
            )
              ..width = context.mWidth > 960 ? 500.0 : 300.0
              ..height = 100.0,
            'Happy Hacking!, Dart... Dart...'.n
              ..color = ctl.state().themeColor[2]
              ..fontSize = context.mWidth > 960 ? 20 : 15,
            const SizedBox(height: 15),
            'This UI is powered by'.n
              ..color = ctl.state().themeColor[2]
              ..fontSize = context.mWidth > 960 ? 20 : 15,
            const SizedBox(height: 30),
            'Fluent UI'.n
              ..color = ctl.state().themeColor[2]
              ..fontSize = context.mWidth > 960 ? 60 : 40,
          ]),
        ),
      );
}

final class HomeCardCrypto extends StatelessWidget {
  const HomeCardCrypto({super.key});

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<FluentService>(
        builder: (final ctl) => Card(
          backgroundColor: ctl.state().themeColor[1],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          padding: EdgeInsets.symmetric(
            horizontal: 100,
            vertical: context.mWidth > 960 ? 75 : 5,
          ),
          child: n.Column([
            const SizedBox(height: 45),
            ListenViewModel<DataService>(
              builder: (final ctlData) => n.Text(
                ctlData.state().isEmpty
                    ? 'Store state: Not yet.'
                    : 'Store state: Yes, you write. ${ctlData.state}',
              )
                ..fontSize = 20
                ..color = ctl.state().themeColor[2]
                ..n.center,
            ),
            const SizedBox(height: 45),
            ViewModel<BinanceService>(
              builder: (final ctlServ) =>
                  BaseQueryBuilder<Bitcoin, FetchException>(
                'bitcoin_fetch',
                def: Bitcoin.detached(),
                ctlServ.getBitcoin,
                loading: () => const ProgressRing(value: 35),
                error: (final _, final error) => n.Column(
                  [
                    const SizedBox(height: 120),
                    error == null
                        ? ('An error occurred'.n..fontSize = 20)
                        : (error.message.n..fontSize = 20),
                  ],
                ),
                success: (final _, final data) => n.Column([
                  'Symbol: ${data.symbol}'.n
                    ..color = ctl.state().themeColor[2]
                    ..fontSize = 20,
                  'Price: ${data.price}'.n
                    ..color = ctl.state().themeColor[2]
                    ..fontSize = 20,
                  const SizedBox(height: 45),
                ]),
              ),
            ),
          ]),
        ),
      );
}
