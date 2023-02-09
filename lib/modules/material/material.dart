import 'package:flutter/material.dart';

import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/modules/material/providers/material_provider.dart';
import 'package:flutterfly/modules/material/views/home/home.dart';
import 'package:flutterfly/modules/material/views/store/store.dart';

class MaterialModule extends StatelessWidget {

  const MaterialModule({super.key});

  @override
  Widget build(context) => MaterialApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      splashFactory: InkRipple.splashFactory
    ),
    darkTheme: ThemeData.dark().copyWith(
      splashFactory: InkRipple.splashFactory
    ),
    themeMode: context.watch(materialProvider)
      ? ThemeMode.dark
      : ThemeMode.light,
    initialRoute: '/',
    routes: { '/': (_) => const Home(), '/store': (_) => const Store() }
  );
}