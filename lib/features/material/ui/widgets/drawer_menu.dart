import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/di/inject.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(
    final BuildContext context,
  ) =>
      Drawer(
        child: n.Column([
          const Spacer(flex: 2),
          ListenViewModel<MaterialService>(
            builder: (final ctl) => DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ctl.isDark
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
            ..onTap = inject.get<MaterialService>().toggle,
          const Spacer(flex: 15),
          ListenViewModel<MaterialService>(
            builder: (final ctl) => n.Image.asset(
              ctl.isDark ? 'assets/brandwhite.png' : 'assets/brand.png',
            )
              ..width = 250.0
              ..height = 75.0,
          ),
        ]),
      );
}
