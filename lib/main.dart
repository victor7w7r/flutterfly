import 'package:flutter/widgets.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart' show appWindow, doWhenWindowReady;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;
import 'package:riverpod_context/riverpod_context.dart' show InheritedConsumer;

import 'package:flutterfly/app.dart';
import 'package:flutterfly/config/inject/inject.dart';
import 'package:flutterfly/core/utils/platforms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjection();

  if(isDesktopOnly) {
    doWhenWindowReady(() => appWindow
      ..minSize = const Size(640, 360)
      ..size = const Size(1280, 720)
      ..alignment = Alignment.center
      ..title = 'Flutterfly'
      ..show()
    );
  }

  runApp(const ProviderScope(
    child: InheritedConsumer(child: App())
  ));

}
