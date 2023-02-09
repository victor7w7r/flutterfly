import 'package:flutter/cupertino.dart';

import 'package:conditioned/conditioned.dart' show Case, Conditioned;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/modules/common/widgets/title_bar.dart';
import 'package:flutterfly/modules/cupertino/providers/cupertino_provider.dart';
import 'package:flutterfly/modules/cupertino/views/crypto/crypto.dart';
import 'package:flutterfly/modules/cupertino/views/home/home.dart';
import 'package:flutterfly/modules/cupertino/views/store/store.dart';
import 'package:flutterfly/utils/platforms.dart';

class CupertinoModule extends StatelessWidget {

  const CupertinoModule({super.key});

  @override
  Widget build(context) {

    final dark = context.watch(cupertinoProvider);

    return CupertinoApp(
      title: 'flutterfly',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
      brightness: dark
        ? Brightness.dark
        : Brightness.light
      ),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Conditioned(
            cases: [
              Case(isMacOS, builder: () => WindowTitleBar(isDark: dark)),
              Case(!isDesktop, builder: () => 'CupertinoApp'.n..freezed)
            ],
            defaultBuilder: () => n.Stack([
              'CupertinoApp'.n
                ..freezed
                ..mx = 10
                ..my = 5,
              WindowTitleBar(isDark: dark)
            ])
          )
        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar),
                label: 'Crypto'
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book),
                label: 'Store'
              )
            ]
          ),
          tabBuilder: (_, i) => const [Home(), Crypto(), Store()][i]
        )
      )
    );
  }
}