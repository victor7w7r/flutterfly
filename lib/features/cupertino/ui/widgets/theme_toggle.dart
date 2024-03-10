import 'package:flutter/cupertino.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';

final class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(
    final BuildContext context,
  ) =>
      n.Wrap([
        'Dark Mode'.n
          ..freezed
          ..fontSize = 13,
        Transform.scale(
          scale: 0.7,
          child: ListenViewModel<CupertinoService>(
            builder: (final ctl) => CupertinoSwitch(
              value: ctl.isDark,
              onChanged: (final _) async => ctl.toggle(),
              thumbColor: CupertinoColors.white,
              activeColor: CupertinoColors.activeBlue,
            ),
          ),
        ),
      ])
        ..crossAxisAlignment = WrapCrossAlignment.center
        ..spacing = -5;
}
