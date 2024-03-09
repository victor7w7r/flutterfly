import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutterfly/features/cupertino/ui/widgets/title.dart';
import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto.dart';
import 'package:flutterfly/features/cupertino/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/cupertino/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/cupertino/ui/providers/cupertino.riverpod.dart';

final class CupertinoModule extends ConsumerWidget {
  const CupertinoModule({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final dark = ref.watch(cupertinoProvider$);

    return CupertinoApp(
      title: 'flutterfly',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: dark ? Brightness.dark : Brightness.light,
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
          tabBuilder: (final _, final i) =>
              const [Home(), Crypto(), Store()][i],
        ),
      ),
    );
  }
}
