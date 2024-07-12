// coverage:ignore-file

import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

import 'package:watch_it/watch_it.dart';

class Platform {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  bool get isAndroidOnly =>
      defaultTargetPlatform == TargetPlatform.android && !kIsWeb;

  bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows;

  bool get isIos => defaultTargetPlatform == TargetPlatform.iOS;

  bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  bool get isMacOSOnly =>
      defaultTargetPlatform == TargetPlatform.macOS && !kIsWeb;

  bool get isPlatform =>
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      kIsWeb;

  bool get isPlatformNotMac =>
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows ||
      kIsWeb;

  bool get isWeb => kIsWeb;

  bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;
}

void setUpPlatform() => GetIt.I.registerFactory<Platform>(Platform.new);
