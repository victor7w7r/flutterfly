import 'package:flutter/foundation.dart' show defaultTargetPlatform;

import 'package:flutter/widgets.dart' show Color, TargetPlatform;

import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:provider/single_child_widget.dart';

import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/providers/data_provider.dart';
import 'package:flutterfly/providers/binance_provider.dart';

import 'package:flutterfly/modules/material/providers/theme_provider.dart';
import 'package:flutterfly/modules/cupertino/providers/theme_provider.dart';
import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';

List<SingleChildWidget> dynamicProviders() {
  if(defaultTargetPlatform == TargetPlatform.iOS) {
    return [
        ChangeNotifierProvider(create: ( _ ) =>
          ThemeCupertinoProvider(isDarkmode: Preferences.darkModeCupertino, darkMode: Preferences.darkModeCupertino)),
        ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
        ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  } else if(defaultTargetPlatform == TargetPlatform.android) {
    return [
        ChangeNotifierProvider(create: ( _ ) =>
          ThemeMaterialProvider(isDarkmode: Preferences.darkModeMaterial, darkMode: Preferences.darkModeMaterial)),
        ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
        ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  } else {
    return [
      ChangeNotifierProvider(create: ( _ ) =>
        ThemeFluentProvider(
          darkMode: Preferences.darkModeMaterial,
          backgroundColor: Preferences.darkModeMaterial ? const Color(0xFF18171C) : const Color(0xFFFFFFFF),
          cardColor: const Color(0xFF20242D),
          invertedColor: const Color(0xFFFFFFFF)
        )
      ),
      ChangeNotifierProvider(create: ( _ ) =>
        ThemeCupertinoProvider(isDarkmode: Preferences.darkModeCupertino, darkMode: Preferences.darkModeCupertino)),
      ChangeNotifierProvider(create: ( _ ) =>
        ThemeMaterialProvider(isDarkmode: Preferences.darkModeMaterial, darkMode: Preferences.darkModeMaterial)),
      ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
      ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false)
    ];
  }
}