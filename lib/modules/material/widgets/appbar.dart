import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show Consumer;
import 'package:niku/namespace.dart' as n;

import 'package:flutterfly/modules/common/widgets/index.dart';
import 'package:flutterfly/modules/material/providers/material_provider.dart';
import 'package:flutterfly/utils/platforms.dart';

PreferredSizeWidget appBar(String title) => AppBar(
  elevation: 0.0,
  toolbarHeight: isMacOS ? 30 : null,
  leading: isMacOS ? nil : null,
  title: isMacOS ? Consumer(builder: (_, ref, __) =>
    WindowTitleBar(isDark: ref.watch(materialProvider)
  )) : n.Stack([
    title.n,
    if(isDesktop) Consumer(builder: (_, ref, __) =>
      WindowTitleBar(isDark: ref.watch(materialProvider)
    ))
  ]),
  actions: isMacOS ? [
    Builder(
      builder: (ctx) => n.IconButton(Icons.menu)
        ..ml = 10
        ..pt = 4
        ..onPressed = Scaffold.of(ctx).openEndDrawer,
    )
  ] : null
);