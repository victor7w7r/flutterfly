import 'package:flutter/material.dart';

import 'package:provider/provider.dart' show Provider;
import 'package:auto_route/auto_route.dart';

import 'package:flutterfly/modules/material/providers/theme_provider.dart' show ThemeMaterialProvider;

class DrawerMenu extends StatefulWidget {

  const DrawerMenu({Key? key, this.onTap}) : super(key: key);
  final Function()? onTap;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();

}

class _DrawerMenuState extends State<DrawerMenu> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeMaterialProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          const Spacer(flex: 2),
          DrawerHeader(decoration: _togglerHeader(), child: Container()),
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
        onTap: () => context.navigateNamedTo('/home')
      ),
      ListTile(
        leading: const Icon( Icons.store_outlined ), title: const Text('Store'),
        onTap: () => context.navigateNamedTo('/store')
      ),
      ListTile(
        leading: const Icon( Icons.color_lens_outlined),
        title: const Text('Change Color Mode'),
        onTap: () {
          final themeProvider = Provider.of<ThemeMaterialProvider>(context, listen: false);
          themeProvider.toggle();
          setState(() {});
          widget.onTap!();
        }
      )
    ];
  }

  BoxDecoration _togglerHeader() {
    final themeProvider = Provider.of<ThemeMaterialProvider>(context, listen: false);
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