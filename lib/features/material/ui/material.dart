import 'package:flutter/material.dart';

import 'package:flutterfly/core/mvvm/base_mvvm.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/material/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class MaterialModule extends StatelessWidget {
  const MaterialModule({super.key});

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<MaterialService>(
        builder: (final ctl) => MaterialApp(
          title: 'flutterfly',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            splashFactory: InkRipple.splashFactory,
          ),
          darkTheme:
              ThemeData.dark().copyWith(splashFactory: InkRipple.splashFactory),
          themeMode: ctl.isDark ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          routes: {
            '/': (final _) => const HomePage(),
            '/store': (final _) => const StorePage(),
          },
        ),
      );
}
