import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

import 'package:flutterfly/modules/cupertino/tabs/home_tab.dart';
import 'package:flutterfly/modules/cupertino/tabs/store_tab.dart';
import 'package:flutterfly/modules/cupertino/widgets/theme_toggle.dart';

class CupertinoHome extends StatefulWidget {
  const CupertinoHome({Key? key}) : super(key: key);

  @override
  State<CupertinoHome> createState() => _CupertinoHomeState();
}

class _CupertinoHomeState extends State<CupertinoHome> {
  final List<Widget> _tabs = [const HomeTab(), const StoreTab()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoApp'),
        trailing: ThemeToggle(),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store')
          ]
        ),
        tabBuilder: (BuildContext context, index)  => _tabs[index]
      )
    );
  }
}