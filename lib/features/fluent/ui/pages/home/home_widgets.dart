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
        onPressed: onClick,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(back),
          elevation: WidgetStateProperty.all<double>(0),
          shape: WidgetStateProperty.all<CircleBorder>(
            CircleBorder(side: BorderSide(color: border, width: 4)),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(25),
        ),
      );
}

final class HomeCardBrand extends StatelessWidget {
  const HomeCardBrand({super.key, this.child});

  final Widget? child;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      child ??
      ListenViewModel<FluentService>(
        builder: (final ctl) => Card(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          backgroundColor: ctl.state.themeColor[1],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: n.Column([
            'Made with love by'.n
              ..fontFamily = 'AminaReska'
              ..color = ctl.state.themeColor[2]
              ..fontSize = context.mWidth > 960 ? 20 : 15,
            n.Image.asset(
              'assets/${ctl.state.isDark ? 'brandwhite' : 'brand'}.png',
            )
              ..width = context.mWidth > 960 ? 500.0 : 300.0
              ..height = 100.0,
            'Happy Hacking!, Dart... Dart...'.n
              ..color = ctl.state.themeColor[2]
              ..fontSize = context.mWidth > 960 ? 20 : 15,
            const SizedBox(height: 15),
            'This UI is powered by'.n
              ..color = ctl.state.themeColor[2]
              ..fontSize = context.mWidth > 960 ? 20 : 15,
            const SizedBox(height: 30),
            'Fluent UI'.n
              ..color = ctl.state.themeColor[2]
              ..fontSize = context.mWidth > 960 ? 60 : 40,
          ]),
        ),
      );
}

final class HomeCardCrypto extends StatelessWidget {
  const HomeCardCrypto({super.key, this.child, this.mockError = false});

  final Widget? child;

  final bool mockError;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      child ??
      ListenViewModel<FluentService>(
        builder: (final ctl) => Card(
          padding: EdgeInsets.symmetric(
            vertical: context.mWidth > 960 ? 75 : 5,
            horizontal: 100,
          ),
          backgroundColor: ctl.state.themeColor[1],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: n.Column([
            const SizedBox(height: 45),
            ListenViewModel<DataService>(
              builder: (final ctlData) => n.Text(
                ctlData.state.isEmpty
                    ? 'Store state: Not yet.'
                    : 'Store state: Yes, you write. ${ctlData.state}',
              )
                ..fontSize = 20
                ..color = ctl.state.themeColor[2]
                ..n.center,
            ),
            const SizedBox(height: 45),
            ViewModel<BinanceService>(
              builder: (final ctlServ) =>
                  BaseQueryBuilder<Bitcoin, FetchException>(
                'bitcoin_fetch',
                ctlServ.getBitcoin,
                loading: () => const ProgressRing(value: 35),
                error: (final _, final error) => n.Column([
                  const SizedBox(height: 120),
                  error == null
                      ? ('An error occurred'.n..fontSize = 20)
                      // coverage:ignore-start
                      : (error.message.n..fontSize = 20),
                  // coverage:ignore-end
                ]),
                success: (final _, final data) => n.Column([
                  'Symbol: ${data.symbol}'.n
                    ..color = ctl.state.themeColor[2]
                    ..fontSize = 20,
                  'Price: ${data.price}'.n
                    ..color = ctl.state.themeColor[2]
                    ..fontSize = 20,
                  const SizedBox(height: 45),
                ]),
                def: Bitcoin.detached(),
                mockError: mockError,
              ),
            ),
          ]),
        ),
      );
}
