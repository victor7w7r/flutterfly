import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/cupertino.dart' show CupertinoApp;
import 'package:fluent_ui/fluent_ui.dart' show FluentApp;
import 'package:flutter/widgets.dart' show BuildContext;

import 'package:provider/provider.dart' show Provider;
import 'package:flutterfly/modules/material/providers/theme_provider.dart';
import 'package:flutterfly/modules/cupertino/providers/theme_provider.dart';
import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';

import 'package:flutterfly/routers/cupertino_router.gr.dart';
import 'package:flutterfly/routers/material_router.gr.dart';
import 'package:flutterfly/routers/fluent_router.gr.dart';

CupertinoApp cupertinoApp(BuildContext context, CupertinoAppRouter desktopAppRouter) {
  return CupertinoApp.router(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    routerDelegate: desktopAppRouter.delegate(),
    routeInformationParser: desktopAppRouter.defaultRouteParser(),
    theme: Provider.of<ThemeCupertinoProvider>(context).currentTheme
  );
}

MaterialApp materialApp(BuildContext context, MaterialAppRouter materialAppRouter) {
  return MaterialApp.router(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    routerDelegate: materialAppRouter.delegate(),
    routeInformationParser: materialAppRouter.defaultRouteParser(),
    theme: Provider.of<ThemeMaterialProvider>(context).currentTheme
  );
}

FluentApp fluentApp(BuildContext context, FluentAppRouter desktopAppRouter) {
  return FluentApp.router(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    routerDelegate: desktopAppRouter.delegate(),
    routeInformationParser: desktopAppRouter.defaultRouteParser(),
    color: Provider.of<ThemeFluentProvider>(context).color,
  );

}