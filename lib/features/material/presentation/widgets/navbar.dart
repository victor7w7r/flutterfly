import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/presentation/widgets/widgets.dart';
import 'package:flutterfly/features/material/providers/material.riverpod.dart';

final class NavBar extends StatelessWidget {

  const NavBar(
    this.title, {super.key}
  );

  final String title;

  @override
  Widget build(final BuildContext context) => AppBar(
    elevation: 0.0,
    toolbarHeight: isMacOS ? 30 : null,
    leading: isMacOS ? Container() : null,
    title: isMacOS ? AppConsumer((final ref) =>
      WindowTitleBar(isDark: ref.watch(materialProvider$)
    )) : n.Stack([
      title.n,
      if(isDesktop) AppConsumer((final ref) =>
        WindowTitleBar(isDark: ref.watch(materialProvider$)
      ))
    ]),
    actions: isMacOS ? [
      Builder(
        builder: (final ctx) => n.IconButton(Icons.menu)
          ..ml = 10
          ..pt = 4
          ..onPressed = Scaffold.of(ctx).openEndDrawer
      )
    ] : null
  );
}
