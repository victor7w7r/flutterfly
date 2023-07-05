import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show ConsumerWidget;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/presentation/screens/desktop_selector.dart';
import 'package:flutterfly/features/common/providers/desktop_provider.dart';
import 'package:flutterfly/features/cupertino/cupertino.dart';
import 'package:flutterfly/features/fluent/fluent.dart';
import 'package:flutterfly/features/material/material.dart';

final class App extends ConsumerWidget {

  const App({ super.key });

  @override
  Widget build(context, ref) {

    final desktop = ref.watch(desktopProvider$);

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