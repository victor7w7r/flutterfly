import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/resources/extensions.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';

final class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    required this.sym,
    required this.per,
    required this.pri,
    super.key,
  });

  final String per;
  final String pri;
  final String sym;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<CupertinoService>(
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
                    BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: 2,
                    ),
                  )
                : const Border.fromBorderSide(BorderSide(width: 2)),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: n.Column([
            switch (context.mWidth) {
              > 720 => const SizedBox(height: 45),
              > 520 => const SizedBox(height: 20),
              > 320 => const SizedBox(height: 10),
              _ => const SizedBox(height: 5)
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
            ..crossAxisAlignment = CrossAxisAlignment.start,
        ),
      );
}
