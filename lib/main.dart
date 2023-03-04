import 'package:flutter/widgets.dart';

import 'package:conditioned/conditioned.dart' show Conditioned, Case;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;
import 'package:nester/nester.dart' show Nester;
import 'package:riverpod_context/riverpod_context.dart' show InheritedConsumer, RiverpodContext;

import 'package:flutterfly/config/index.dart';
import 'package:flutterfly/utils/platforms.dart';
import 'package:flutterfly/modules/common/providers/desktop_provider.dart';
import 'package:flutterfly/modules/common/views/desktop_selector.dart';
import 'package:flutterfly/modules/cupertino/cupertino.dart';
import 'package:flutterfly/modules/fluent/fluent.dart';
import 'package:flutterfly/modules/material/material.dart';

void main() => setup().then((_) => runApp(
  Nester.list([
    (next) => ProviderScope(child: next),
    (next) => InheritedConsumer(child: next),
    (_) => const FlutterflyApp()
  ])
));

class FlutterflyApp extends StatelessWidget {

  const FlutterflyApp({super.key});

  @override
  Widget build(context) {

    final desktop = context.watch(desktopProvider);

    return Conditioned(
      cases: [
        Case(isIos, builder: CupertinoModule.new),
        Case(isAndroid, builder: MaterialModule.new),
        Case(isDesktop && desktop != 'none', builder: () => Conditioned(
          cases: [
            Case(desktop == 'material', builder: MaterialModule.new),
            Case(desktop == 'cupertino', builder: CupertinoModule.new),
          ],
          defaultBuilder: FluentModule.new
        ))
      ],
      defaultBuilder: DesktopSelector.new
    );
  }
}
