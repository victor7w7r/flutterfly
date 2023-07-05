import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show ConsumerWidget;

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/features/cupertino/providers/cupertino_provider.dart';

final class ThemeToggle extends ConsumerWidget {

  const ThemeToggle({super.key});

  @override
  Widget build(context, ref) => n.Wrap([
    'Dark Mode'.n
      ..freezed
      ..fontSize = 13,
    Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
        value: ref.watch(cupertinoProvider$),
        onChanged: (_) =>
          ref.read(cupertinoProvider$.notifier).toggle(),
        thumbColor: CupertinoColors.white,
        activeColor: CupertinoColors.activeBlue
      )
    )
  ])
    ..crossAxisAlignment = WrapCrossAlignment.center
    ..spacing = -5;
}