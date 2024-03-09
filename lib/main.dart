import 'package:flutter/widgets.dart';

import 'package:flutterfly/core/di/di.dart';
import 'package:flutterfly/core/mappers/fic_mappers.dart';
import 'package:flutterfly/core/mvvm/base_mvvm.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_page.dart';
import 'package:flutterfly/features/common/ui/services/desktop_service.dart';
import 'package:flutterfly/features/cupertino/ui/cupertino.dart';
import 'package:flutterfly/features/fluent/ui/fluent.dart';
import 'package:flutterfly/features/material/ui/material.dart';
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
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<DesktopService>(
        builder: (final ctl) {
          if (isIos) {
            return const CupertinoModule();
          } else if (isAndroid) {
            return const MaterialModule();
          } else if (isDesktop && ctl.state != 'none') {
            if (ctl.state == 'material') {
              return const MaterialModule();
            } else if (ctl.state == 'cupertino') {
              return const CupertinoModule();
            } else {
              return const FluentModule();
            }
          } else {
            return const DesktopSelectorPage();
          }
        },
      );
}
