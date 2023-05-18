import 'package:flutter/widgets.dart';
import 'package:flutterfly/features/common/presentation/views/desktop_selector.dart';

import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/data/providers/desktop_provider.dart';
import 'package:flutterfly/features/cupertino/cupertino.dart';
import 'package:flutterfly/features/fluent/fluent.dart';
import 'package:flutterfly/features/material/material.dart';

final class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(context) {

    final desktop = context.watch(desktopProvider);

    if(isIos) {
      return const CupertinoModule();
    } else if(isAndroid) {
      return const MaterialModule();
    } else if(isDesktop && desktop != 'none') {
      if(desktop == 'material') {
        return const MaterialModule();
      } else if(desktop == 'cupertino') {
        return const CupertinoModule();
      } else {
        return const FluentModule();
      }
    } else {
      return const DesktopSelector();
    }
  }
}