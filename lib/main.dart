import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/widgets.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart' show appWindow, doWhenWindowReady;

import 'package:flutterfly/platforms/index.dart';

void main() {
  runApp(const MyApp());

  doWhenWindowReady(() => appWindow
    ..minSize = const Size(640, 360)
    ..size = const Size(1280, 720)
    ..alignment = Alignment.center
    ..title = "Flutterfly"
    ..show()
  );

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(context) {
    if(defaultTargetPlatform == TargetPlatform.iOS) {
      return cupertinoApp(context);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return materialApp(context);
    } else {
      return fluentApp(context);
    }
  }
}