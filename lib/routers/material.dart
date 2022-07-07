import 'package:flutter/material.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/modules/material/providers/theme_provider.dart';

import 'package:flutterfly/modules/material/screens/home_screen.dart';
import 'package:flutterfly/modules/material/screens/store_screen.dart';

MaterialApp materialApp(BuildContext context) {
  return MaterialApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    initialRoute: HomeScreen.routerName,
    routes: <String, WidgetBuilder> {
      HomeScreen.routerName: (_) => const HomeScreen(),
      StoreScreen.routerName: (_) => const StoreScreen()
    },
    theme: Provider.of<ThemeMaterialProvider>(context).currentTheme
  );
}