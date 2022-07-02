import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/screens/screens.dart';
import 'package:flutterfly/providers/providers.dart' show ThemeProvider;

class DrawerMenu extends StatefulWidget {

  const DrawerMenu({Key? key, this.onTap}) : super(key: key);
  final Function()? onTap;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();

}

class _DrawerMenuState extends State<DrawerMenu> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          const Spacer(flex: 2),
          DrawerHeader(decoration: togglerHeader(), child: Container()),
          const Spacer(flex: 1),
          _tiles(context)[0],
          _tiles(context)[1],
          const Spacer(flex: 8),
          _tiles(context)[2],
          const Spacer(flex: 15),
          Image.asset(themeProvider.darkState ? 'assets/brandwhite.png' : 'assets/brand.png', width: 250.0, height: 75.0)
        ],
      ),
    );
  }

  List<ListTile> _tiles(BuildContext context) {
    return [
      ListTile(
        leading: const Icon( Icons.home_outlined ), title: const Text('Home'),
        onTap: () => Navigator.pushReplacementNamed(context, HomeScreen.routerName)
      ),
      ListTile(
        leading: const Icon( Icons.store_outlined ), title: const Text('Store'),
        onTap: () => Navigator.pushReplacementNamed(context, StoreScreen.routerName )
      ),
      ListTile(
        leading: const Icon( Icons.color_lens_outlined),
        title: const Text('Change Color Mode'),
        onTap: () {
          final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
          themeProvider.toggle();
          setState(() {});
          widget.onTap!();
        }
      )
    ];
  }

  BoxDecoration togglerHeader() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    if ( themeProvider.darkState ) {
      return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/aqua-light.png'), fit: BoxFit.scaleDown
        )
      );
    } else {
        return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/aqua-black.png'), fit: BoxFit.scaleDown
        )
      );
    }
  }
}