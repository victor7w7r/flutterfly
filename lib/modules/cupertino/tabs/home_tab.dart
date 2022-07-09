import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart';

import 'package:flutterfly/share_preferences/preferences.dart';

import 'package:flutterfly/modules/cupertino/widgets/widgets.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  bool value = Preferences.darkModeCupertino;

  @override
  Widget build(BuildContext context) {

    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        const Positioned(
          top: 70,
          right: 0,
          child: ThemeToggle()
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const DynamicChip(selector: 'brand'),
            const SizedBox(height: 10),
            Center(
              child: Text("Happy Hacking!, Dart... Dart...",
              style: TextStyle(fontSize: (size.height > 960 ) ? 25 : 10))
            ),
            const SizedBox(height: 10),
            dataProvider.data.isEmpty
              ? Center(
                  child: Text('Store state: Not yet.',
                  style: TextStyle(fontSize: (size.height>960) ? 20 : 15)))
              : Center(
                child: Text("Store state: Yes, you write. ${dataProvider.data}",
                style: const TextStyle(fontSize: 20))),
            const SizedBox(height: 20),
            const Center(child: Text("Made with love by ", style: TextStyle(fontSize: 15))),
            const SizedBox(height: 20),
            const DynamicChip(selector: 'home')
          ]
        )
      ]
    );
  }
}