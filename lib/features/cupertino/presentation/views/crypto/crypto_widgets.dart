import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/config/extensions/extensions.dart';
import 'package:flutterfly/features/cupertino/data/providers/cupertino_provider.dart';

final class CurrencyCard extends StatelessWidget {

  final String sym;
  final String per;
  final String pri;

  const CurrencyCard({
    super.key,
    required this.sym,
    required this.per,
    required this.pri
  });

  @override
  Widget build(context) => Container(
    margin: const EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 5
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 10
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      border: context.watch(cupertinoProvider)
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
      switch(context.mWidth) {
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
        ..fontWeight = FontWeight.bold
    ])
      ..crossAxisAlignment = CrossAxisAlignment.start
  );
}