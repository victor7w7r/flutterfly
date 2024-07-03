// coverage:ignore-file

import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

import 'package:injectable/injectable.dart';

@injectable
class Platform {
  bool isWeb() => kIsWeb;

  bool isPlatform() =>
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      kIsWeb;

  bool isPlatformNotMac() =>
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows ||
      kIsWeb;

  bool isDesktop() =>
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows;

  bool isWindows() => defaultTargetPlatform == TargetPlatform.windows;

  bool isLinux() => defaultTargetPlatform == TargetPlatform.linux;

  bool isIos() => defaultTargetPlatform == TargetPlatform.iOS;

  bool isMacOS() => defaultTargetPlatform == TargetPlatform.macOS;

  bool isAndroid() => defaultTargetPlatform == TargetPlatform.android;

  bool isAndroidOnly() =>
      defaultTargetPlatform == TargetPlatform.android && !kIsWeb;

  bool isMacOSOnly() =>
      defaultTargetPlatform == TargetPlatform.macOS && !kIsWeb;
}
