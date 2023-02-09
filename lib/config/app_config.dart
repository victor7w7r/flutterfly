import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart' show appWindow, doWhenWindowReady;
import 'package:fpdart/fpdart.dart' show FpdartOnNullable;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'package:flutterfly/utils/index.dart';

@singleton
class AppConfig {

  late final SharedPreferences prefs;
  late final bool materialDark;
  late final bool cupertinoDark;
  late final bool fluentDark;

  @FactoryMethod(preResolve: true)
  static Future<AppConfig> init() async {

    WidgetsFlutterBinding.ensureInitialized();

    final config = AppConfig()
      ..prefs = await SharedPreferences.getInstance();

    config.prefs.getBool('materialdark').toOption().fold(
      () => config.prefs.setBool('materialdark', true)
        .then((_) => config.materialDark = true),
      (dark) => config.materialDark = dark
    );

    config.prefs.getBool('cupertinodark').toOption().fold(
      () => config.prefs.setBool('cupertinodark', true)
        .then((_) => config.cupertinoDark = true),
      (dark) => config.cupertinoDark = dark
    );

    config.prefs.getBool('fluentdark').toOption().fold(
      () => config.prefs.setBool('fluentdark', true)
        .then((_) => config.fluentDark = true),
      (dark) => config.fluentDark = dark
    );

    if(isDesktopOnly) {
      doWhenWindowReady(() => appWindow
        ..minSize = const Size(640, 360)
        ..size = const Size(1280, 720)
        ..alignment = Alignment.center
        ..title = "Flutterfly"
        ..show()
      );
    }

    return config;
  }
}