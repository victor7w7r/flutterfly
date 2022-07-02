import 'dart:io' show Platform;

import 'package:flutter/widgets.dart'
  show runApp, StatelessWidget, Widget,
    BuildContext, Key, WidgetsFlutterBinding;

import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/cupertino.dart' show CupertinoApp;
import 'package:flutterfly/providers/theme_cupertino_provider.dart';

import 'package:provider/provider.dart' show MultiProvider, ChangeNotifierProvider, Provider;

import 'package:flutterfly/providers/providers.dart';
import 'package:flutterfly/share_preferences/preferences.dart';

import 'router.gr.dart';

final _appRouter = AppRouter();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ThemeCupertinoProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
        ChangeNotifierProvider(create: ( _ ) => ThemeMaterialProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
        ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
        ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    if(Platform.isIOS) {
      return CupertinoApp.router(
        title: 'flutterfly',
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: Provider.of<ThemeCupertinoProvider>(context).currentTheme
      );
    } else {
      return MaterialApp.router(
        title: 'flutterfly',
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: Provider.of<ThemeMaterialProvider>(context).currentTheme
      );
    }
  }
}