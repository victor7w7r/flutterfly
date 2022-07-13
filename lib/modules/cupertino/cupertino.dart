import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show CupertinoProvider;

import 'package:flutterfly/modules/cupertino/tabs/tabs.dart';

class CupertinoModule extends StatefulWidget {
  const CupertinoModule({Key? key}) : super(key: key);

  @override
  State<CupertinoModule> createState() => _CupertinoModuleState();
}

class _CupertinoModuleState extends State<CupertinoModule> {

  final _tabs = [
    const HomeTab(),
    const CryptoTab(),
    const StoreTab()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'flutterfly',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<CupertinoProvider>(context).currentTheme,
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('CupertinoApp')
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
          tabBuilder: (BuildContext context, index) => _tabs[index]
        )
      )
    );
  }
}





