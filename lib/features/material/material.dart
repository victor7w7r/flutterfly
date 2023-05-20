import 'package:flutter/material.dart';

import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/features/material/data/providers/material_provider.dart';
import 'package:flutterfly/features/material/presentation/views/home/home.dart';
import 'package:flutterfly/features/material/presentation/views/store/store.dart';

final class MaterialModule extends StatelessWidget {

  const MaterialModule({super.key});

  @override
  Widget build(context) => MaterialApp(
    title: 'flutterfly',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      splashFactory: InkRipple.splashFactory
    ),
    darkTheme: ThemeData.dark().copyWith(
      splashFactory: InkRipple.splashFactory
    ),
    themeMode: context.watch(materialProvider)
      ? ThemeMode.dark
      : ThemeMode.light,
    initialRoute: '/',
    routes: {
      '/': (_) => const Home(),
      '/store': (_) => const Store()
    }
  );
}