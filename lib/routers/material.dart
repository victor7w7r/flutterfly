import 'package:flutter/material.dart' show MaterialApp, BuildContext;

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show MaterialProvider;

import 'package:flutterfly/modules/material/screens/home_screen.dart';
import 'package:flutterfly/modules/material/screens/store_screen.dart';

MaterialApp materialApp(BuildContext context) {
  return MaterialApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    initialRoute: HomeScreen.routerName,
    routes: {
      HomeScreen.routerName: (_) => const HomeScreen(),
      StoreScreen.routerName: (_) => const StoreScreen()
    },
    theme: Provider.of<MaterialProvider>(context).currentTheme
  );
}