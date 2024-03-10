import 'package:flutter/material.dart';
import 'package:flutterfly/core/mvvm/base_mvvm.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/widgets/widgets.dart';

final class NavBar extends StatelessWidget {
  const NavBar(this.title, {super.key});

  final String title;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      AppBar(
        elevation: 0.0,
        toolbarHeight: isMacOS ? 30 : null,
        leading: isMacOS ? Container() : null,
        title: isMacOS
            ? ListenViewModel<MaterialService>(
                builder: (final ctl) => WindowTitleBar(isDark: ctl.isDark),
              )
            : n.Stack([
                title.n,
                if (isDesktop)
                  ListenViewModel<MaterialService>(
                    builder: (final ctl) => WindowTitleBar(isDark: ctl.isDark),
                  ),
              ]),
        actions: isMacOS
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
