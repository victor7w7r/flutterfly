import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/modules/cupertino/providers/theme_provider.dart';

import 'package:flutterfly/modules/cupertino/cupertino_home.dart';

CupertinoApp cupertinoApp(BuildContext context) {
  return CupertinoApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    theme: Provider.of<ThemeCupertinoProvider>(context).currentTheme,
    home: const CupertinoHome()
  );
}