import 'package:fluent_ui/fluent_ui.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';

import 'package:flutterfly/modules/fluent/screens/home_screen.dart';
import 'package:flutterfly/modules/fluent/screens/store_screen.dart';

FluentApp fluentApp(BuildContext context) {
  return FluentApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routerName,
      routes: <String, WidgetBuilder> {
        HomeScreen.routerName: ( _ ) => const HomeScreen(),
        StoreScreen.routerName: ( _ ) => const StoreScreen()
      },
    color: Provider.of<ThemeFluentProvider>(context).backgroundColor,
  );
}