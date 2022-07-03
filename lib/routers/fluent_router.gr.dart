// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../modules/fluent/screens/home_screen.dart' as _i1;
import '../modules/fluent/screens/store_screen.dart' as _i2;

class FluentAppRouter extends _i3.RootStackRouter {
  FluentAppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeScreen.name: (routeData) {
      return _i3.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomeScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    StoreScreen.name: (routeData) {
      return _i3.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.StoreScreen(),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: 'home', fullMatch: true),
        _i3.RouteConfig(HomeScreen.name, path: 'home'),
        _i3.RouteConfig(StoreScreen.name, path: 'store')
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreen extends _i3.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: 'home');

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i2.StoreScreen]
class StoreScreen extends _i3.PageRouteInfo<void> {
  const StoreScreen() : super(StoreScreen.name, path: 'store');

  static const String name = 'StoreScreen';
}
