import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutterfly/screens/store_screen.dart';
import '../screens/home_screen.dart';

import 'package:flutterfly/share_preferences/preferences.dart';
import 'package:flutterfly/providers/theme_provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {

  bool value = Preferences.isDarkmode;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: 
      Column(
        children: [
          const Spacer(flex: 2),
          DrawerHeader(
            child: Container(),
            decoration: togglerHeader()
          ),
          const Spacer(flex: 1),
          ListTile(
            leading: const Icon( Icons.home_outlined ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routerName );
            },
          ),
          ListTile(
            leading: const Icon( Icons.store_outlined ),
            title: const Text('Store'),
            onTap: () {
                Navigator.pushReplacementNamed(context, StoreScreen.routerName );
            },
          ),
          const Spacer(flex: 10),
          ListTile(
            leading: const Icon( Icons.color_lens_outlined),
            title: const Text('Change Color Mode'),
            onTap: () {
              final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              value = !value;
              Preferences.isDarkmode = value;
                value 
                  ? themeProvider.setDarkmode() 
                  : themeProvider.setLightMode();
                setState(() {});
            },
          ),
          const Spacer(flex: 15),
          Image.asset( value ? 'assets/brandwhite.png' : 'assets/brand.png', width: 250.0, height: 75.0)
        ],
      ),
    );
  }

  BoxDecoration togglerHeader() {
    if ( value ) {
      return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/aqua-light.png'),
          fit: BoxFit.scaleDown
        )
      );
    } else {
        return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/aqua-black.png'),
          fit: BoxFit.scaleDown
        )
      );
    }
  }
}
