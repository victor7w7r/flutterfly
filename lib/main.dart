import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart' show MultiProvider;

import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/modules/desktop_selector.dart';
import 'package:flutterfly/dynamic_providers.dart';

import 'package:flutterfly/modules/cupertino/cupertino.dart';
import 'package:flutterfly/modules/fluent/fluent.dart';
import 'package:flutterfly/modules/material/material.dart';

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
      return const CupertinoModule();
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return materialApp(context);
    } else if (_desktopBool && _isDesktop) {
        switch(_desktopSelector) {
        case 'material': return materialApp(context);
        case 'cupertino': return const CupertinoModule();
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
