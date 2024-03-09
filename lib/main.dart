import 'package:flutter/widgets.dart';

import 'package:flutterfly/core/di/di.dart';
import 'package:flutterfly/core/mappers/fic_mappers.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/screens/desktop_selector.dart';
import 'package:flutterfly/features/cupertino/cupertino.dart';
import 'package:flutterfly/features/fluent/fluent.dart';
import 'package:flutterfly/features/material/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart'
    show appWindow, doWhenWindowReady;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFICMappers();
  await configInjection();
  if (isDesktopOnly) {
    doWhenWindowReady(
      () => appWindow
        ..minSize = const Size(360, 360)
        ..size = const Size(1280, 720)
        ..alignment = Alignment.center
        ..title = 'Flutterfly'
        ..show(),
    );
  }

  runApp(const App());
}

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) {
    final desktop = ref.watch(desktopProvider$);

    if (isIos) {
      return const CupertinoModule();
    } else if (isAndroid) {
      return const MaterialModule();
    } else if (isDesktop && desktop != 'none') {
      if (desktop == 'material') {
        return const MaterialModule();
      } else if (desktop == 'cupertino') {
        return const CupertinoModule();
      } else {
        return const FluentModule();
      }
    } else {
      return const DesktopSelector();
    }
  }
}
