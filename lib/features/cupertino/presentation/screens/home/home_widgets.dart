import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tailwind_colors/tailwind_colors.dart' show TWColors;

import 'package:flutterfly/features/cupertino/providers/cupertino.riverpod.dart';

final class DynamicChip extends ConsumerWidget {
  const DynamicChip({required this.isHome, super.key});

  final bool isHome;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final dark = ref.watch(cupertinoProvider$);

    return Container(
      width: isHome ? 300 : 270,
      height: isHome ? 60 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: dark
            ? Border.all(width: 2, color: TWColors.gray.shade100)
            : Border.all(width: 2, color: TWColors.gray.shade900),
      ),
      child: n.Row(
        isHome
            ? [
                const SizedBox(width: 38),
                n.Image.asset(
                  dark ? 'assets/brandwhite.png' : 'assets/brand.png',
                )
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
