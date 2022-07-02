import 'package:auto_route/auto_route.dart' show CustomAutoRouter, AutoRoute, CustomRoute;

import 'package:flutterfly/screens/flutterfly.dart';
import 'package:flutterfly/screens/home_screen.dart';
import 'package:flutterfly/screens/store_screen.dart';

import 'package:flutterfly/utils/transitions.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: Flutterfly,
      initial: true,
      children: [
        CustomRoute(
          path: 'home',
          page: HomeScreen,
          initial: true
        ),
        CustomRoute(
          path: 'store',
          page: StoreScreen,
          transitionsBuilder: materialTransition,
          durationInMilliseconds: 400
        ),
      ]
    )
  ]
)
class $AppRouter {}