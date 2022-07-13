import 'package:fluent_ui/fluent_ui.dart' show FluentApp, BuildContext;

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show FluentProvider;

import 'package:flutterfly/modules/fluent/screens/home_screen.dart';
import 'package:flutterfly/modules/fluent/screens/store_screen.dart';

FluentApp fluentApp(BuildContext context) {
  return FluentApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    initialRoute: HomeScreen.routerName,
    routes: {
      HomeScreen.routerName: ( _ ) => const HomeScreen(),
      StoreScreen.routerName: ( _ ) => const StoreScreen()
    },
    color: Provider.of<FluentProvider>(context).backgroundColor
  );
}