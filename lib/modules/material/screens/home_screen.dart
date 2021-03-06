import 'package:flutter/material.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show DataProvider;

import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/modules/material/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  static const String routerName = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool value = Preferences.darkModeMaterial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Home'), elevation: 0.0),
      drawer: DrawerMenu(callback: () => setState((){})),
      body: OrientationBuilder(builder: (context, orientation) =>
        Flex(
          direction: orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
          children: [
            Expanded(flex: 1, child: _firstColumn(context, orientation)),
            Expanded(
              flex: orientation == Orientation.portrait ? 2 : 1,
              child: _secondColumn(context, orientation)
            )
          ]
        )
      )
    );
  }

  Column _firstColumn(BuildContext context, Orientation orientation) {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: orientation == Orientation.portrait ? 30 : size.height / 3.5),
        DynamicChip(value: value, selector: 'brand'),
        const SizedBox(height: 15),
        Center(
          child: Text("Happy Hacking!, Dart... Dart...",
          style: TextStyle(fontSize: (size.height > 960 ) ? 30 : 20))
        ),
        const SizedBox(height: 10),
        dataProvider.data.isEmpty ? (
        Center(
            child: Text('Store state: Not yet.', style: TextStyle(fontSize: (size.height>960) ? 20 : 15))
          )
        ) : (
          Center(
            child: Text("Store state: Yes, you write. ${dataProvider.data}", style: const TextStyle(fontSize: 20))
          )
        ),
        const SizedBox(height: 25),
        const Center(child: Text("Made with love by ", style: TextStyle(fontSize: 15))),
        const SizedBox(height: 20),
        DynamicChip(value: value, selector: 'home')
      ]
    );
  }

  Column _secondColumn(BuildContext context, Orientation orientation) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 35),
        Center(child: Text("Cryptocurrency data", style: TextStyle(fontSize: (size.height>960) ? 35 : 30))),
        const SizedBox(height: 25),
        HomeCurrencyList(orientation: orientation)
      ]
    );
  }
}