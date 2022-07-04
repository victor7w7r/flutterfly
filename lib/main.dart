import 'dart:io' show Platform;

import 'package:flutter/widgets.dart' show WidgetsFlutterBinding, runApp, Color;
import 'package:provider/provider.dart' show MultiProvider, ChangeNotifierProvider;
import 'package:provider/single_child_widget.dart';

import 'package:flutterfly/flutterfly.dart';

import 'package:flutterfly/share_preferences/preferences.dart';
import 'package:flutterfly/providers/data_provider.dart';
import 'package:flutterfly/providers/binance_provider.dart';

import 'package:flutterfly/modules/material/providers/theme_provider.dart';
import 'package:flutterfly/modules/cupertino/providers/theme_provider.dart';
import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(providers: dynamicProviders(), child: const FlutterflyApp()));
}

List<SingleChildWidget> dynamicProviders() {
  if(Platform.isIOS) {
    return [
        ChangeNotifierProvider(create: ( _ ) =>
          ThemeCupertinoProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
        ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
        ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  } else if(Platform.isAndroid) {
    return [
        ChangeNotifierProvider(create: ( _ ) =>
          ThemeMaterialProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
        ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
        ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  } else {
    return [
      ChangeNotifierProvider(create: ( _ ) =>
        ThemeFluentProvider(
          darkMode: true,
          backgroundColor: const Color(0xFF18171C),
          cardColor: const Color(0xFF20242D),
          invertedColor: const Color(0xFFFFFFFF)
          )
        ),
      ChangeNotifierProvider(create: ( _ ) =>
        ThemeCupertinoProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
      ChangeNotifierProvider(create: ( _ ) =>
        ThemeMaterialProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
      ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
      ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  }
}