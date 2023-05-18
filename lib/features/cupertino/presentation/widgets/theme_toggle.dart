import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/features/cupertino/data/providers/cupertino_provider.dart';

class ThemeToggle extends StatelessWidget {

  const ThemeToggle({super.key});

  @override
  Widget build(context) => n.Wrap([
    'Dark Mode'.n
      ..freezed
      ..fontSize = 13,
    Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
        value: context.watch(cupertinoProvider),
        onChanged: (_) =>
          context.read(cupertinoProvider.notifier).toggle(),
        thumbColor: CupertinoColors.white,
        activeColor: CupertinoColors.activeBlue
      )
    )
  ])
    ..crossAxisAlignment = WrapCrossAlignment.center
    ..spacing = -5;
}