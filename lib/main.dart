import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart' show MultiProvider;

import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/desktop_selector.dart';
import 'package:flutterfly/dynamic_providers.dart';

import 'package:flutterfly/routers/cupertino.dart';
import 'package:flutterfly/routers/fluent.dart';
import 'package:flutterfly/routers/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(providers: dynamicProviders(), child: const FlutterflyApp()));
}

class FlutterflyApp extends StatefulWidget {
  const FlutterflyApp({Key? key}) : super(key: key);

  @override
  State<FlutterflyApp> createState() => _FlutterflyAppState();
}

class _FlutterflyAppState extends State<FlutterflyApp> {

  bool _isDesktop = false;
  String _desktopSelector = '';

  final _desktopBool = defaultTargetPlatform == TargetPlatform.linux
    || defaultTargetPlatform == TargetPlatform.macOS
    || defaultTargetPlatform == TargetPlatform.windows;

  @override
  Widget build(BuildContext context) {
    if(defaultTargetPlatform == TargetPlatform.iOS) {
      return cupertinoApp(context);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return materialApp(context);
    } else if (_desktopBool && _isDesktop) {
        switch(_desktopSelector) {
        case 'material': return materialApp(context);
        case 'cupertino': return cupertinoApp(context);
        default: return fluentApp(context);
      }
    } else {
      return DesktopSelector(callback: (value) =>
        setState(() {
          _desktopSelector = value;
          _isDesktop = true;
        })
      );
    }
  }
}
