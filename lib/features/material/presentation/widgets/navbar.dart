import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/presentation/widgets/widgets.dart';
import 'package:flutterfly/features/material/data/providers/material_provider.dart';

class NavBar extends StatelessWidget {

  final String title;

  const NavBar(
    this.title, {super.key}
  );

  @override
  Widget build(context) => AppBar(
    elevation: 0.0,
    toolbarHeight: isMacOS ? 30 : null,
    leading: isMacOS ? Container() : null,
    title: isMacOS ? AppConsumer((ref) =>
      WindowTitleBar(isDark: ref.watch(materialProvider)
    )) : n.Stack([
      title.n,
      if(isDesktop) AppConsumer((ref) =>
        WindowTitleBar(isDark: ref.watch(materialProvider)
      ))
    ]),
    actions: isMacOS ? [
      Builder(
        builder: (ctx) => n.IconButton(Icons.menu)
          ..ml = 10
          ..pt = 4
          ..onPressed = Scaffold.of(ctx).openEndDrawer
      )
    ] : null
  );
}