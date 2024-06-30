import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/di/inject.dart';
import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/widgets/widgets.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class NavBar extends StatelessWidget {
  const NavBar(this.title, {super.key});

  final String title;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      AppBar(
        elevation: 0.0,
        toolbarHeight: inject.get<Platform>().isMacOS() ? 30 : null,
        leading: inject.get<Platform>().isMacOS() ? Container() : null,
        title: inject.get<Platform>().isMacOS()
            ? ListenViewModel<MaterialService>(
                builder: (final ctl) => WindowTitleBar(isDark: ctl.isDark),
              )
            : n.Stack([
                title.n,
                if (inject.get<Platform>().isDesktop())
                  ListenViewModel<MaterialService>(
                    builder: (final ctl) => WindowTitleBar(isDark: ctl.isDark),
                  ),
              ]),
        actions: inject.get<Platform>().isMacOS()
            ? [
                Builder(
                  builder: (final ctx) => n.IconButton(Icons.menu)
                    ..ml = 10
                    ..pt = 4
                    ..onPressed = Scaffold.of(ctx).openEndDrawer,
                ),
              ]
            : null,
      );
}
