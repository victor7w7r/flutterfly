import 'package:flutter/cupertino.dart';
import 'package:flutterfly/features/cupertino/presentation/widgets/title.dart';

import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:flutterfly/features/cupertino/data/providers/cupertino_provider.dart';
import 'package:flutterfly/features/cupertino/presentation/views/crypto/crypto.dart';
import 'package:flutterfly/features/cupertino/presentation/views/home/home.dart';
import 'package:flutterfly/features/cupertino/presentation/views/store/store.dart';

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
          middle: CupTitle(dark),
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
          tabBuilder: (_, i) => const [
            Home(), Crypto(), Store()
          ][i]
        )
      )
    );
  }
}