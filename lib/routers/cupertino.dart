import 'package:flutter/cupertino.dart' show CupertinoApp, BuildContext;

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show CupertinoProvider;

import 'package:flutterfly/modules/cupertino/cupertino_home.dart';

CupertinoApp cupertinoApp(BuildContext context) {
  return CupertinoApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    theme: Provider.of<CupertinoProvider>(context).currentTheme,
    home: const CupertinoHome()
  );
}