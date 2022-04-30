import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutterfly/providers/data_provider.dart';
import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/widgets/brand_chip.dart';
import 'package:flutterfly/widgets/drawer_menu.dart';
import 'package:flutterfly/widgets/logo_chip.dart';

class HomeScreen extends StatefulWidget {

  static const String routerName = 'Home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  bool value = Preferences.isDarkmode;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text('My Home'),
          elevation: 0.0
      ),
      drawer: DrawerMenu(onTap: () {
        setState(() {
          value = Preferences.isDarkmode;
        });
      }),
      body: OrientationBuilder(   
        builder:(context, orientation) {
          return GridView.count( 
            crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
              //physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: orientation == Orientation.portrait ? 1/.9 : 1,
            children: [
              Container(
                color: Colors.pinkAccent,
                child: firstColumn(context, orientation),
              ),
        
              Container(
                color: Colors.cyanAccent,
                child: secondColumn(),
              )
            ]
          );
        }
      )
    );
  }

  Widget firstColumn(BuildContext context, Orientation orientation) {

    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
  
    return Column(
      children: [
        SizedBox(height: orientation == Orientation.portrait ? 50 : size.height / 6),
        logoChip(value),
        const SizedBox(height: 15),
        const Center(child: Text("Happy Hacking!, Dart... Dart...", style: TextStyle(fontSize: 30))),
        const SizedBox(height: 10),
        dataProvider.data!.isEmpty ? (
          const Center(  
            child: Text('Store state: Not yet.', style: TextStyle(fontSize: 20)),
          )
        ) : (
          Center(  
            child: Text("Store state: Yes, you write. ${dataProvider.data}", style: const TextStyle(fontSize: 20)),
          )
        ),
        const SizedBox(height: 25),
        const Center(child: Text("Made with love by ", style: TextStyle(fontSize: 15))),
        const SizedBox(height: 30),
        brandChip(value)
      ],
    );
  }

  Widget secondColumn() {
    return Column(
      children: const [
        SizedBox(height: 25),
        Center(child: Text("Cryptocurrency data", style: TextStyle(fontSize: 35))), 
      ]);
  }
}