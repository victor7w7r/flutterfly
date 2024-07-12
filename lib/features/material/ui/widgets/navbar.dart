import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart' show GetIt;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/widgets/widgets.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class NavBar extends StatelessWidget {
  const NavBar(this.title, {super.key, this.child});

  final Widget? child;
  final String title;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      AppBar(
        leading: GetIt.I<Platform>().isMacOS ? Container() : null,
        title: GetIt.I<Platform>().isMacOS
            ? ListenViewModel<MaterialService>(
                builder: (final ctl) =>
                    WindowTitleBar(isDark: ctl.isDark, child: child),
              )
            : n.Stack([
                title.n,
                if (GetIt.I<Platform>().isDesktop)
                  ListenViewModel<MaterialService>(
                    builder: (final ctl) =>
                        WindowTitleBar(isDark: ctl.isDark, child: child),
                  ),
              ]),
        actions: GetIt.I<Platform>().isMacOS
            ? [
                Builder(
                  builder: (final ctx) => n.IconButton(Icons.menu)
                    ..ml = 10
                    ..pt = 4
                    ..onPressed = Scaffold.of(ctx).openEndDrawer,
                ),
              ]
            : null,
        elevation: 0.0,
        toolbarHeight: GetIt.I<Platform>().isMacOS ? 30 : null,
      );
}
