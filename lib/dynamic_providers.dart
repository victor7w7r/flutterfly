import 'package:flutter/foundation.dart' show defaultTargetPlatform;

import 'package:flutter/widgets.dart' show Color, TargetPlatform;

import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:provider/single_child_widget.dart';

import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/providers/providers.dart';

List<SingleChildWidget> dynamicProviders() {
  if(defaultTargetPlatform == TargetPlatform.iOS) {
    return [
      ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
      ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false),
      ChangeNotifierProvider(
        create: ( _ ) => CupertinoProvider(
          isDarkmode: Preferences.darkModeCupertino,
          darkMode: Preferences.darkModeCupertino
        )
      )
    ];
  } else if(defaultTargetPlatform == TargetPlatform.android) {
    return [
      ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
      ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false),
      ChangeNotifierProvider(
        create: ( _ ) => MaterialProvider(
          isDarkmode: Preferences.darkModeMaterial,
          darkMode: Preferences.darkModeMaterial
        )
      )
    ];
  } else {
    return [
      ChangeNotifierProvider(create: ( _ ) => DataProvider(data: "")),
      ChangeNotifierProvider(create: ( _ ) => BinanceProvider(), lazy: false),
      ChangeNotifierProvider(
        create: ( _ ) => FluentProvider(
          darkMode: Preferences.darkModeMaterial,
          backgroundColor: Preferences.darkModeMaterial
            ? const Color(0xFF18171C)
            : const Color(0xFFFFFFFF),
          cardColor: const Color(0xFF20242D),
          invertedColor: const Color(0xFFFFFFFF)
        )
      ),
      ChangeNotifierProvider(
        create: ( _ ) => CupertinoProvider(
          isDarkmode: Preferences.darkModeCupertino,
          darkMode: Preferences.darkModeCupertino
        )
      ),
      ChangeNotifierProvider(
        create: ( _ ) => MaterialProvider(
          isDarkmode: Preferences.darkModeMaterial,
          darkMode: Preferences.darkModeMaterial
        )
      ),
    ];
  }
}