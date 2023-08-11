import 'package:flutter/widgets.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart' show appWindow, doWhenWindowReady;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'package:flutterfly/app.dart';
import 'package:flutterfly/core/modules/prefs.module.dart';
import 'package:flutterfly/core/utils/platforms.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if(isDesktopOnly) {
    doWhenWindowReady(() => appWindow
      ..minSize = const Size(640, 360)
      ..size = const Size(1280, 720)
      ..alignment = Alignment.center
      ..title = 'Flutterfly'
      ..show()
    );
  }

  runApp(ProviderScope(
    overrides: [
      sharedPrefs$.overrideWithValue(
        await SharedPreferences.getInstance()
      )
    ],
    child: const App()
  ));

}
