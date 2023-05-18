import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/features/cupertino/data/providers/cupertino_provider.dart';

final class DynamicChip extends StatelessWidget {

  final bool isHome;

  const DynamicChip({
    super.key,
    required this.isHome
  });

  @override
  Widget build(context) {

    final dark = context.watch(cupertinoProvider);

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
        n.Image.asset(
          dark ? 'assets/brandwhite.png': 'assets/brand.png'
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