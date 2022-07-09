import 'package:flutter/material.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show MaterialProvider;

import 'package:flutterfly/modules/material/screens/home_screen.dart';
import 'package:flutterfly/modules/material/screens/store_screen.dart';

class DrawerMenu extends StatelessWidget {

  const DrawerMenu({Key? key, required this.callback}) : super(key: key);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<MaterialProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          const Spacer(flex: 2),
          DrawerHeader(decoration: _togglerHeader(context), child: Container()),
          const Spacer(flex: 1),
          _tiles(context)[0],
          _tiles(context)[1],
          const Spacer(flex: 8),
          _tiles(context)[2],
          const Spacer(flex: 15),
          Image.asset(
            themeProvider.darkMode
              ? 'assets/brandwhite.png'
              : 'assets/brand.png',
            width: 250.0, height: 75.0
          )
        ]
      )
    );
  }

  List<ListTile> _tiles(BuildContext context) {
    final themeProvider = Provider.of<MaterialProvider>(context, listen: false);
    return [
      ListTile(
        leading: const Icon(Icons.home_outlined), title: const Text('Home'),
        onTap: () => () => Navigator.pushReplacementNamed(context, HomeScreen.routerName)
      ),
      ListTile(
        leading: const Icon(Icons.store_outlined), title: const Text('Store'),
        onTap: () => Navigator.pushReplacementNamed(context, StoreScreen.routerName )
      ),
      ListTile(
        leading: const Icon(Icons.color_lens_outlined),
        title: const Text('Change Color Mode'),
        onTap: () {
          themeProvider.toggle();
          callback();
        }
      )
    ];
  }

  BoxDecoration _togglerHeader(BuildContext context) {
    final themeProvider = Provider.of<MaterialProvider>(context, listen: false);
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          themeProvider.darkMode
            ? 'assets/aqua-light.png' : 'assets/aqua-black.png'
          ),
        fit: BoxFit.scaleDown
      )
    );
  }
}