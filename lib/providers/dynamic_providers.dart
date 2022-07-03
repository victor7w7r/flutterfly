import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:provider/single_child_widget.dart';

import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/providers/data_provider.dart';
import 'package:flutterfly/providers/binance_provider.dart';

import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';
import 'package:flutterfly/modules/cupertino/providers/theme_provider.dart';
import 'package:flutterfly/modules/material/providers/theme_provider.dart';

List<SingleChildWidget> dynamicProviders() {

  if(Platform.isIOS) {
    return [
        ChangeNotifierProvider(create: ( _ ) => ThemeCupertinoProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
        ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
        ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  } else if(Platform.isAndroid) {
    return [
        ChangeNotifierProvider(create: ( _ ) => ThemeMaterialProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
        ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
        ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  } else {
    return [
      ChangeNotifierProvider(create: ( _ ) => ThemeFluentProvider(darkState: false, color: const Color.fromRGBO(255, 255, 255, 0))),
      ChangeNotifierProvider(create: ( _ ) => ThemeCupertinoProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
      ChangeNotifierProvider(create: ( _ ) => ThemeMaterialProvider(isDarkmode: Preferences.isDarkmode, darkState: Preferences.isDarkmode)),
      ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
      ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  }
}