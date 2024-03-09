import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/features/common/ui/widgets/consumer.dart';
import 'package:flutterfly/features/material/ui/providers/material.riverpod.dart';

final class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(
    final BuildContext context,
    final WidgetRef ref,
  ) =>
      Drawer(
        child: n.Column([
          const Spacer(flex: 2),
          AppConsumer(
            (final ref) => DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ref.watch(materialProvider$)
                        ? 'assets/aqua-light.png'
                        : 'assets/aqua-black.png',
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
              child: Container(),
            ),
          ),
          const Spacer(),
          n.ListTile()
            ..leading = n.Icon(Icons.home_outlined)
            ..title = 'Home'.n
            ..onTap = () async => Navigator.of(context).pushNamed('/'),
          n.ListTile()
            ..leading = n.Icon(Icons.store_outlined)
            ..title = 'Store'.n
            ..onTap = () async => Navigator.of(context).pushNamed('/store'),
          const Spacer(flex: 8),
          n.ListTile()
            ..leading = n.Icon(Icons.color_lens_outlined)
            ..title = 'Change Color Mode'.n
            ..onTap = ref.read(materialProvider$.notifier).toggle,
          const Spacer(flex: 15),
          AppConsumer(
            (final ref) => n.Image.asset(
              ref.watch(materialProvider$)
                  ? 'assets/brandwhite.png'
                  : 'assets/brand.png',
            )
              ..width = 250.0
              ..height = 75.0,
          ),
        ]),
      );
}
