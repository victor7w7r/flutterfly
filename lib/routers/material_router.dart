import 'package:auto_route/auto_route.dart' show MaterialAutoRouter, AutoRoute;

import 'package:flutterfly/modules/material/screens/home_screen.dart';
import 'package:flutterfly/modules/material/screens/store_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(path: 'home', page: HomeScreen, initial: true),
    AutoRoute(path: 'store', page: StoreScreen)
  ]
)
class $MaterialAppRouter {}