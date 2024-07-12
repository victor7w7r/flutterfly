import 'package:flutter/material.dart';

import 'package:fl_query/fl_query.dart' show QueryClientProvider;

import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/material/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class MaterialLayout extends StatelessWidget {
  const MaterialLayout({super.key, this.child});

  final Widget? child;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<MaterialService>(
        builder: (final ctl) => QueryClientProvider(
          child: MaterialApp(
            routes: {
              '/': (final _) => HomePage(child: child),
              '/store': (final _) => StorePage(child: child),
            },
            initialRoute: '/',
            title: 'flutterfly',
            theme: ThemeData(
              splashFactory: InkRipple.splashFactory,
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark()
                .copyWith(splashFactory: InkRipple.splashFactory),
            themeMode: ctl.isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
}
