import 'package:flutter/foundation.dart' show
  TargetPlatform, defaultTargetPlatform, kIsWeb;

final isDesktop = defaultTargetPlatform == TargetPlatform.linux
  || defaultTargetPlatform == TargetPlatform.macOS
  || defaultTargetPlatform == TargetPlatform.windows
  || kIsWeb;

final isDesktopOnly = defaultTargetPlatform == TargetPlatform.linux
  || defaultTargetPlatform == TargetPlatform.macOS
  || defaultTargetPlatform == TargetPlatform.windows;

final isAndroid =
  defaultTargetPlatform == TargetPlatform.android;

final isMacOS =
  defaultTargetPlatform == TargetPlatform.macOS;

final isIos =
  defaultTargetPlatform == TargetPlatform.iOS;

const isWeb = kIsWeb;
