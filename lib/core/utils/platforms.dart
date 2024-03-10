import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

final isDesktop = defaultTargetPlatform == TargetPlatform.linux ||
    defaultTargetPlatform == TargetPlatform.macOS ||
    defaultTargetPlatform == TargetPlatform.windows ||
    kIsWeb;

final isDesktopOnly = defaultTargetPlatform == TargetPlatform.linux ||
    defaultTargetPlatform == TargetPlatform.macOS ||
    defaultTargetPlatform == TargetPlatform.windows;

final isAndroid = defaultTargetPlatform == TargetPlatform.android && !kIsWeb;

final isMacOS = defaultTargetPlatform == TargetPlatform.macOS && !kIsWeb;

final isIos = defaultTargetPlatform == TargetPlatform.iOS && !kIsWeb;

const isWeb = kIsWeb;
