import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

import 'package:flutterfly/modules/cupertino/tabs/tabs.dart';

class CupertinoHome extends StatefulWidget {
  const CupertinoHome({Key? key}) : super(key: key);

  @override
  State<CupertinoHome> createState() => _CupertinoHomeState();
}

class _CupertinoHomeState extends State<CupertinoHome> {

  final _tabs = [
    const HomeTab(),
    const CryptoTab(),
    const StoreTab()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoApp')
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Crypto'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store')
          ]
        ),
        tabBuilder: (BuildContext context, index) => _tabs[index]
      )
    );
  }
}