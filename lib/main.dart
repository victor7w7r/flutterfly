import 'package:flutter/widgets.dart';

import 'package:flutterfly/app.dart';
import 'package:flutterfly/core/di/inject.dart';
import 'package:flutterfly/core/utils/platforms.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart'
    show appWindow, doWhenWindowReady;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjection();
  if (Platform().isDesktop()) {
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
