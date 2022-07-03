import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart' show MultiProvider;

import 'package:flutterfly/providers/dynamic_providers.dart';
import 'package:flutterfly/share_preferences/preferences.dart';
import 'package:flutterfly/desktop_selector.dart';
import 'package:flutterfly/platforms.dart';

import 'package:flutterfly/routers/cupertino_router.gr.dart';
import 'package:flutterfly/routers/material_router.gr.dart';
import 'package:flutterfly/routers/fluent_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(providers: dynamicProviders(), child: const App()));
}

final _materialAppRouter = MaterialAppRouter();
final _cupertinoAppRouter = CupertinoAppRouter();
final _fluentAppRouter = FluentAppRouter();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  bool _isDesktop = false;
  String _desktopSelector = '';

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS && !_isDesktop) {
      return cupertinoApp(context, _cupertinoAppRouter);
    } else if (Platform.isAndroid && !_isDesktop) {
      return materialApp(context, _materialAppRouter);
    } else if (_desktopSelector != '' && _isDesktop) {
      switch(_desktopSelector) {
        case 'material':
          return materialApp(context, _materialAppRouter);
        case 'cupertino':
          return cupertinoApp(context, _cupertinoAppRouter);
        default:
          return fluentApp(context, _fluentAppRouter);
      }
    } else {
      return DesktopSelector(callback: (value) {
        setState(() {
          _desktopSelector = value;
          _isDesktop = true;
        });
      });
    }
  }
}