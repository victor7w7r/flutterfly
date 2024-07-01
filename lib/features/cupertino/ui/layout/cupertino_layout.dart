import 'package:flutter/cupertino.dart';

import 'package:fl_query/fl_query.dart' show QueryClientProvider;

import 'package:flutterfly/core/utils/mvvm.dart';
import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto_page.dart';
import 'package:flutterfly/features/cupertino/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/cupertino/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/cupertino/ui/widgets/title.dart';

final class CupertinoLayout extends StatelessWidget {
  const CupertinoLayout({super.key, this.child});

  final Widget? child;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      ListenViewModel<CupertinoService>(
        builder: (final ctl) => QueryClientProvider(
          child: CupertinoApp(
            title: 'flutterfly',
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              brightness: ctl.isDark() ? Brightness.dark : Brightness.light,
            ),
            home: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: CupTitle(ctl.isDark(), child: child),
              ),
              child: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.money_dollar),
                      label: 'Crypto',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.book),
                      label: 'Store',
                    ),
                  ],
                ),
                tabBuilder: (final _, final i) => [
                  HomePage(child: child),
                  CryptoPage(child: child),
                  StorePage(child: child),
                ][i],
              ),
            ),
          ),
        ),
      );
}
