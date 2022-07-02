// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import 'screens/flutterfly.dart' as _i1;
import 'screens/home_screen.dart' as _i2;
import 'screens/store_screen.dart' as _i3;
import 'utils/transitions.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    Flutterfly.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.Flutterfly(),
          opaque: true,
          barrierDismissible: false);
    },
    HomeScreen.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.HomeScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    StoreScreen.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.StoreScreen(),
          transitionsBuilder: _i6.materialTransition,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(Flutterfly.name, path: '/', children: [
          _i4.RouteConfig('#redirect',
              path: '',
              parent: Flutterfly.name,
              redirectTo: 'home',
              fullMatch: true),
          _i4.RouteConfig(HomeScreen.name,
              path: 'home', parent: Flutterfly.name),
          _i4.RouteConfig(StoreScreen.name,
              path: 'store', parent: Flutterfly.name)
        ])
      ];
}

/// generated route for
/// [_i1.Flutterfly]
class Flutterfly extends _i4.PageRouteInfo<void> {
  const Flutterfly({List<_i4.PageRouteInfo>? children})
      : super(Flutterfly.name, path: '/', initialChildren: children);

  static const String name = 'Flutterfly';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreen extends _i4.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: 'home');

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i3.StoreScreen]
class StoreScreen extends _i4.PageRouteInfo<void> {
  const StoreScreen() : super(StoreScreen.name, path: 'store');

  static const String name = 'StoreScreen';
}
