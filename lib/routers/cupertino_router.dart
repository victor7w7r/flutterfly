import 'package:auto_route/auto_route.dart' show CupertinoAutoRouter, AutoRoute;

import 'package:flutterfly/modules/cupertino/screens/home_screen.dart';
import 'package:flutterfly/modules/cupertino/screens/store_screen.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(path: '/home', page: HomeScreen, initial: true),
    AutoRoute(path: '/store', page: StoreScreen)
  ]
)
class $CupertinoAppRouter {}