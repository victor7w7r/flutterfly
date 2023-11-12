import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/features/material/providers/material.riverpod.dart';
import 'package:flutterfly/features/material/presentation/screens/home/home.dart';
import 'package:flutterfly/features/material/presentation/screens/store/store.dart';

final class MaterialModule extends ConsumerWidget {
  const MaterialModule({super.key});

  @override
  Widget build(
    final BuildContext context,
    final WidgetRef ref,
  ) =>
      MaterialApp(
        title: 'flutterfly',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          splashFactory: InkRipple.splashFactory,
        ),
        darkTheme:
            ThemeData.dark().copyWith(splashFactory: InkRipple.splashFactory),
        themeMode:
            ref.watch(materialProvider$) ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (final _) => const Home(),
          '/store': (final _) => const Store(),
        },
      );
}
