import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart' show CupertinoApp;
import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';
import 'package:flutterfly/modules/cupertino/cupertino_home.dart';

import 'package:provider/provider.dart' show Provider;
import 'package:fluent_ui/fluent_ui.dart' show FluentApp, ThemeData, Colors;

import 'package:flutterfly/desktop_selector.dart';

import 'package:flutterfly/modules/material/providers/theme_provider.dart';
import 'package:flutterfly/modules/cupertino/providers/theme_provider.dart';
import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';

import 'package:flutterfly/routers/material_router.gr.dart';
import 'package:flutterfly/routers/fluent_router.gr.dart';

final _materialAppRouter = MaterialAppRouter();
final _fluentAppRouter = FluentAppRouter();

class FlutterflyApp extends StatefulWidget {
  const FlutterflyApp({Key? key}) : super(key: key);

  @override
  State<FlutterflyApp> createState() => _FlutterflyAppState();
}

class _FlutterflyAppState extends State<FlutterflyApp> {

  bool _isDesktop = false;
  String _desktopSelector = '';

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS && !_isDesktop) {
      return _cupertinoApp(context);
    } else if (Platform.isAndroid && !_isDesktop) {
      return _materialApp(context, _materialAppRouter);
    } else if (_desktopSelector != '' && _isDesktop) {
      switch(_desktopSelector) {
        case 'material':
          return _materialApp(context, _materialAppRouter);
        case 'cupertino':
          return _cupertinoApp(context);
        default:
          return _fluentApp(context, _fluentAppRouter);
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

  CupertinoApp _cupertinoApp(BuildContext context) {
    return CupertinoApp(
      title: 'flutterfly',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeCupertinoProvider>(context).currentTheme,
      home: const CupertinoHome()
    );
  }

  MaterialApp _materialApp(BuildContext context, MaterialAppRouter materialAppRouter) {
    return MaterialApp.router(
      title: 'flutterfly',
      debugShowCheckedModeBanner: false,
      routerDelegate: materialAppRouter.delegate(),
      routeInformationParser: materialAppRouter.defaultRouteParser(),
      theme: Provider.of<ThemeMaterialProvider>(context).currentTheme
    );
  }

  FluentApp _fluentApp(BuildContext context, FluentAppRouter desktopAppRouter) {
    return FluentApp.router(
      title: 'flutterfly',
      debugShowCheckedModeBanner: false,
      routerDelegate: desktopAppRouter.delegate(),
      routeInformationParser: desktopAppRouter.defaultRouteParser(),
      color: Provider.of<ThemeFluentProvider>(context).backgroundColor,
    );
  }
}