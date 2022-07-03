import 'package:auto_route/auto_route.dart' show CustomAutoRouter, AutoRoute;

import 'package:flutterfly/modules/fluent/screens/home_screen.dart';
import 'package:flutterfly/modules/fluent/screens/store_screen.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(path: 'home', page: HomeScreen, initial: true),
    AutoRoute(path: 'store', page: StoreScreen)
  ]
)
class $FluentAppRouter {}