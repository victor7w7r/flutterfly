import 'package:flutter/cupertino.dart';
import 'package:flutterfly/modules/cupertino/widgets/home_currency_list.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart';
import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/modules/cupertino/widgets/home_brand_chip.dart';
import 'package:flutterfly/modules/cupertino/widgets/home_logo_chip.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  bool value = Preferences.darkModeCupertino;

  @override
  Widget build(BuildContext context) {
     // print(value);
    return OrientationBuilder(builder: (context, orientation) =>
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
    );
  }

  Column _firstColumn(BuildContext context, Orientation orientation) {

    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: orientation == Orientation.portrait ? 75 : size.height / 3.5),
        HomeLogoChip(value: value),
        const SizedBox(height: 10),
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
        const SizedBox(height: 20),
        const Center(child: Text("Made with love by ", style: TextStyle(fontSize: 15))),
        const SizedBox(height: 20),
        HomeBrandChip(value: value)
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